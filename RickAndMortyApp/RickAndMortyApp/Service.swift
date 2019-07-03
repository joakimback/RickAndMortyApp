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
    
    func fetchCharacters(for page: Int) -> PromiseKit.Promise<[CharacterDetails]> {
        return PromiseKit.Promise { resolver in
            let query = FetchCharactersQuery(page: page)
            apollo.fetch(query: query) { (result, error) in
                if let error = error {
                    resolver.reject(error)
                    return
                }
                
                guard let characters = result?.data?.characters?.results else {
                    resolver.fulfill([])
                    return
                }
                
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
                if let error = error {
                    resolver.reject(error)
                    return
                }
                
                let location = result?.data?.location
                resolver.fulfill(location?.fragments.locationDetails)
            }
        }
    }
    
    func fetchResidents(for id: GraphQLID) -> PromiseKit.Promise<[CharacterDetails]> {
        return PromiseKit.Promise { resolver in
            let query = FetchLocationResidentsQuery(id: id)
            apollo.fetch(query: query) { (result, error) in
                if let error = error {
                    resolver.reject(error)
                    return
                }
                
                guard let residents = result?.data?.location?.fragments.locationResidents.residents else {
                    resolver.fulfill([])
                    return
                }
                
                resolver.fulfill(residents.compactMap { $0?.fragments.characterDetails })
            }
        }
    }
}
