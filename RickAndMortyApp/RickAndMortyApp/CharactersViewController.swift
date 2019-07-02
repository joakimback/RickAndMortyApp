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

class CharactersViewController: UITableViewController {
    var characters: [CharacterDetails] = []
    var isLoading = false
    var page: Int = 0
    var selectedCharacter: CharacterDetails?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? CharacterDetailsViewController {
            destination.character = selectedCharacter
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNextPage()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        // Fetch the next page if user scrolls to the end
        if index == (characters.count - 1), isLoading == false {
            fetchNextPage()
        }
        
        // Configure cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        cell.configure(for: characters[index])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacter = characters[indexPath.row]
        performSegue(withIdentifier: "CharacterDetailsSegue", sender: nil)
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
