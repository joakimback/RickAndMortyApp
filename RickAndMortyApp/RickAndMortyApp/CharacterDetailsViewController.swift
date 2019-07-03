//
//  CharacterDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-02.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Apollo
import Foundation
import Kingfisher
import PromiseKit
import UIKit

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var originButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var character: CharacterDetails!
    var selectedLocation: LocationDetails!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? LocationDetailsViewController {
            destination.location = selectedLocation
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = character.name
        
        if let url = character.imageURL {
            imageView.kf.setImage(with: url)
        }
        
        nameLabel.text = character.name
        originLabel.text = character.origin?.name
        originButton.isEnabled = character.origin?.id != nil
        locationLabel.text = character.location?.name
        locationButton.isEnabled = character.location?.id != nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavoriteButton()
    }
    
    @IBAction func displayOrigin(_ sender: Any) {
        guard let locationID = character.origin?.id else {
            return
        }
        
        displayLocation(with: locationID)
    }
    
    @IBAction func displayLocation(_ sender: Any) {
        guard let locationID = character.location?.id else {
            return
        }
        
        displayLocation(with: locationID)
    }
    
    @IBAction func toggleFavorite(_ sender: Any) {
        guard let characterID = character.id else {
            return
        }
        
        if (FavoritesController.shared.contains(id: characterID)) {
            FavoritesController.shared.remove(id: characterID)
        } else {
            FavoritesController.shared.add(id: characterID)
        }
        
        updateFavoriteButton()
    }
}

extension CharacterDetailsViewController {
    private func displayLocation(with id: GraphQLID) {
        firstly {
            Service.shared.fetchLocation(id: id)
        }.done {
            guard let locationID = $0 else {
                return
            }
            
            self.selectedLocation = locationID
            self.performSegue(withIdentifier: "LocationDetailsSegue", sender: nil)
        }.catch { _ in
            // Handle error
        }
    }
    
    private func updateFavoriteButton() {
        guard let characterID = character.id else {
            return
        }
        
        if (FavoritesController.shared.contains(id: characterID)) {
            favoriteButton.image = #imageLiteral(resourceName: "726-star-selected")
        } else {
            favoriteButton.image = #imageLiteral(resourceName: "726-star")
        }
    }
}
