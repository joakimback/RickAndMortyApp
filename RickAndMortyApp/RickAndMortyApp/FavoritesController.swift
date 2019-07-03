//
//  FavoritesController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-03.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Apollo
import Foundation

extension Notification.Name {
    static let favoritesDidChange = Notification.Name("favoritesDidChange")
}

class FavoritesController {
    static let shared = FavoritesController()
    
    var favorites: [GraphQLID] = []
    
    func add(id: GraphQLID) {
        favorites.append(id)
        
        // Notify observers
        NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
    }
    
    func remove(id: GraphQLID) {
        favorites = favorites.filter { $0 != id }

        // Notify observers
        NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
    }
    
    func contains(id: GraphQLID) -> Bool {
        return favorites.contains(id)
    }
}
