//
//  CharacterDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-02.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var character: CharacterDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = character.name
        
        if let url = character.imageURL {
            imageView.kf.setImage(with: url)
        }
        
        nameLabel.text = character.name
        originLabel.text = character.origin?.name
        locationLabel.text = character.location?.name
    }
}
