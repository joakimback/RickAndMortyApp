//
//  ApolloController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-01.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Foundation
import Apollo
import PromiseKit

class Service {
    static let shared = Service()
    
    let apollo: ApolloClient
    
    init() {
        let graphQLEndpoint = "https://rickandmortyapi.com/graphql/"
        let url = URL(string: graphQLEndpoint)! // Error handling needed
        apollo = ApolloClient(url: url)
    }
    
    func fetchCharacters(for page: Int, ignoreCache: Bool = false) -> PromiseKit.Promise<[CharacterDetails]> {
        let cachePolicy: CachePolicy = ignoreCache ? .fetchIgnoringCacheData: .returnCacheDataElseFetch
        
        return PromiseKit.Promise { resolver in
            let query = FetchCharactersQuery(page: page)
            apollo.fetch(query: query, cachePolicy: cachePolicy) { (result, error) in
                // Error occurred, fail
                if let error = error {
                    resolver.reject(error)
                    return
                }
                
                // Empty result
                guard let characters = result?.data?.characters?.results else {
                    resolver.fulfill([])
                    return
                }
                
                // Return result
                let details = characters.compactMap {
                    $0?.fragments.characterDetails
                }
                
                resolver.fulfill(details)
            }
        }
    }
    
    func fetchLocation(id: GraphQLID) -> PromiseKit.Promise<LocationDetails?> {
        return PromiseKit.Promise { resolver in
            let query = FetchLocationQuery(id: id)
            apollo.fetch(query: query) { (result, error) in
                // Error occurred, fail
                if let error = error {
                    resolver.reject(error)
                    return
                }
                
                // Return result
                let location = result?.data?.location
                resolver.fulfill(location?.fragments.locationDetails)
            }
        }
    }
    
    func fetchResidents(for id: GraphQLID) -> PromiseKit.Promise<[CharacterDetails]> {
        return PromiseKit.Promise { resolver in
            let query = FetchLocationResidentsQuery(id: id)
            apollo.fetch(query: query) { (result, error) in
                // Error occurred, fail
                if let error = error {
                    resolver.reject(error)
                    return
                }
                
                // Empty result
                guard let residents = result?.data?.location?.fragments.locationResidents.residents else {
                    resolver.fulfill([])
                    return
                }
                
                // Return result
                resolver.fulfill(residents.compactMap { $0?.fragments.characterDetails })
            }
        }
    }
    
    func fetchCharacter(for id: GraphQLID) -> PromiseKit.Promise<CharacterDetails> {
        return PromiseKit.Promise { resolver in
            let query = FetchCharacterQuery(id: id)
            apollo.fetch(query: query) { (result, error) in
                // Error occurred, fail
                if let error = error {
                    resolver.reject(error)
                    return
                }
                
                // Invalid result, fail
                guard let character = result?.data?.character?.fragments.characterDetails else {
                    resolver.reject(ServiceError.runtimeError("Fetching favorites failed"))
                    return
                }
                
                // Return result
                resolver.fulfill(character)
            }
        }
    }
    
    func fetchCharacters(for ids: [GraphQLID]) -> PromiseKit.Promise<[CharacterDetails]> {
        // Fetch individually
        let promises = ids.map {
            fetchCharacter(for: $0)
        }
        
        // Return all
        return when(fulfilled: promises)
    }
}

enum ServiceError: Error {
    case runtimeError(String)
}

