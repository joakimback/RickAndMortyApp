//
//  LocationDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-02.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Apollo
import UIKit
import PromiseKit

class LocationDetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var residentsLabel: UILabel!
    
    var location: LocationDetails!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? ResidentsViewController {
            destination.locationID = location.id
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let location = location else {
            return
        }
        
        title = location.name
        nameLabel.text = location.name
        typeLabel.text = location.type
        dimensionLabel.text = location.dimension
        residentsLabel.text = (location.residents?.count).map { "\($0)" }
    }
    
    @IBAction func showResidents(_ sender: Any) {
        performSegue(withIdentifier: "ResidentSegue", sender: nil)
    }
}
