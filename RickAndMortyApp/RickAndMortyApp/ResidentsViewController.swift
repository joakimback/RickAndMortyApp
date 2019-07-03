//
//  ResidentsViewController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-02.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Apollo
import PromiseKit
import UIKit

class ResidentsViewController: AbstractCharactersViewController {
    var locationID: GraphQLID!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResidents()
    }
}

extension ResidentsViewController {
    private func fetchResidents() {
        guard let locationID = locationID else {
            return
        }
        
        firstly {
            Service.shared.fetchResidents(for: locationID)
            }.done { characters in
                self.characters = characters
                self.tableView.reloadData()
            }.catch { _ in
                // Handle error
        }
    }
}
