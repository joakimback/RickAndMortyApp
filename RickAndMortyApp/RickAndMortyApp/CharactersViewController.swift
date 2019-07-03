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
    var allowNextPage = true
    var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNextPage()
        
        // Add Pull to Refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshCharacters(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch the next page if user scrolls to the end
        if indexPath.row == (characters.count - 1), isLoading == false, allowNextPage {
            fetchNextPage()
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension CharactersViewController {
    @objc private func refreshCharacters(_ sender: Any) {
        resetPage()
    }
    
    private func fetchNextPage() {
        page = page + 1
        isLoading = true
        
        firstly {
            Service.shared.fetchCharacters(for: page)
        }.done { characters in
            self.characters = self.characters + characters
            self.allowNextPage = characters.count > 0
        }.catch { error in
            // Handle errors
        }.finally {
            self.isLoading = false
            self.tableView.reloadData()
        }
    }
    
    private func resetPage() {
        page = 1
        isLoading = true
        refreshControl?.beginRefreshing()

        return firstly {
            Service.shared.fetchCharacters(for: page, ignoreCache: true)
        }.done { characters in
            self.characters = characters
        }.catch { error in
            // Handle errors
        }.finally {
            self.isLoading = false
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
}
