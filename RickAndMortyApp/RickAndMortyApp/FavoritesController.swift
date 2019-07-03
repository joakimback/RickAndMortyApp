//
//  FavoritesController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-03.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Apollo
import Foundation

class FavoritesController {
    static let shared = FavoritesController()
    
    var favorites: [GraphQLID] = []
    
    func add(id: GraphQLID) {
        favorites.append(id)
    }
    
    func remove(id: GraphQLID) {
        favorites = favorites.filter { $0 != id }
    }
    
    func contains(id: GraphQLID) -> Bool {
        return favorites.contains(id)
    }
}
