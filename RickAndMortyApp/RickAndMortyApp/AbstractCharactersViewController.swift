//
//  AbstractCharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-02.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import UIKit

class AbstractCharactersViewController: UITableViewController {
    var characters: [CharacterDetails] = []
    var selectedCharacter: CharacterDetails?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? CharacterDetailsViewController {
            destination.character = selectedCharacter
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        cell.configure(for: characters[index])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacter = characters[indexPath.row]
        performSegue(withIdentifier: "CharacterDetailsSegue", sender: nil)
    }
}
