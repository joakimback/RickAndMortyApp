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
import UIImageColors
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
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var shadeView: ShadeView!
    @IBOutlet weak var letterpressView: LetterpressView!
    
    @IBOutlet var captionLabels: [UILabel]!
    
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
        updateLabels()
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
        
        Favorites.shared.toggle(characterID)
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
        
        if (Favorites.shared.contains(characterID)) {
            favoriteButton.image = #imageLiteral(resourceName: "726-star-selected")
        } else {
            favoriteButton.image = #imageLiteral(resourceName: "726-star")
        }
    }
    
    private func updateLabels() {
        title = character.name
        
        if let url = character.imageURL {
            imageView.kf.setImage(with: url)
            imageView.kf.setImage(with: url) { (result) in
                guard let image = try? result.get().image else {
                    return
                }
                
                if let colors = image.getColors(quality: .low) {
                    self.updateColors(from: colors)
                }
            }
        }
        
        nameLabel.text = character.name
        originLabel.text = character.origin?.name
        originButton.isEnabled = character.origin?.id != nil
        locationLabel.text = character.location?.name
        locationButton.isEnabled = character.location?.id != nil
    }
    
    private func updateColors(from colors: UIImageColors) {
        nameLabel.textColor = colors.primary
        originLabel.textColor = colors.primary
        locationLabel.textColor = colors.primary
        captionLabels.forEach { $0.textColor = colors.secondary }
        cardView.backgroundColor = colors.background
        originButton.tintColor = colors.detail
        locationButton.tintColor = colors.detail
        letterpressView.darkmode = colors.primary.brightness > colors.background.brightness
        shadeView.darkmode = colors.primary.brightness > colors.background.brightness
    }
}

extension Color {
    var brightness: CGFloat {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return brightness
    }
}
