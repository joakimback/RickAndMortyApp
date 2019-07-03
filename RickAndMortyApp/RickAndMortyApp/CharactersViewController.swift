//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-01.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Kingfisher
import UIKit
import PromiseKit

class CharactersViewController: AbstractCharactersViewController {
    var isLoading = false
    var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNextPage()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch the next page if user scrolls to the end
        if indexPath.row == (characters.count - 1), isLoading == false {
            fetchNextPage()
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension CharactersViewController {
    private func fetchNextPage() {
        page = page + 1
        isLoading = true
        
        firstly {
            Service.shared.fetchCharacters(for: page)
        }.done { characters in
            self.characters = self.characters + characters
        }.catch { error in
            // Handle errors
        }.finally {
            self.isLoading = false
            self.tableView.reloadData()
        }
    }
}
