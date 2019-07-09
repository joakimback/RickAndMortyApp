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

class Favorites {
    static let shared = Favorites()
    
    var favorites: [GraphQLID] = []

    func add(_ id: GraphQLID) {
        favorites.append(id)
        
        // Notify observers
        NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
    }
    
    func contains(_ id: GraphQLID) -> Bool {
        return favorites.contains(id)
    }
    
    func toggle(_ id: GraphQLID) {
        if contains(id) {
            remove(id)
        } else {
            add(id)
        }
    }
    
    func remove(_ id: GraphQLID) {
        favorites = favorites.filter { $0 != id }
        
        // Notify observers
        NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
    }
}
