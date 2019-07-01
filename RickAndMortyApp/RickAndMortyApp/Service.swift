//
//  ApolloController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-01.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Foundation
import Apollo

class Service {
    static let shared = Service()
    
    let apollo: ApolloClient
    
    init() {
        let graphQLEndpoint = "https://rickandmortyapi.com/graphql/"
        let url = URL(string: graphQLEndpoint)! // Error handling needed
        apollo = ApolloClient(url: url)
    }
}
