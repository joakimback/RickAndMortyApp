//
//  FavoritesViewController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-03.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import PromiseKit
import UIKit

class FavoritesViewController: AbstractCharactersViewController {
    var favoritesObserver: Any!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFavorites()
        favoritesObserver = NotificationCenter.default.addObserver(forName: .favoritesDidChange, object: nil, queue: nil, using: { [weak self] _ in
            self?.fetchFavorites()
        })
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            let characterID = Favorites.shared.favorites[index]
            
            // Prepare list of favorites and update local copy
            Favorites.shared.remove(characterID)
            characters.remove(at: index)
            
            // Remove from table to sync with data
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.endUpdates()
        }
    }
}

extension FavoritesViewController {
    private func fetchFavorites() {
        let characterIDs = Favorites.shared.favorites
        
        firstly {
            Service.shared.fetchCharacters(for: characterIDs)
        }.done { characters in
            self.characters = characters
            self.tableView.reloadData()
        }.catch { _ in
            // Handle error
        }
    }
}
