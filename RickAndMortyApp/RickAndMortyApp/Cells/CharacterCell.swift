//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-02.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var iconView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.kf.cancelDownloadTask()
    }
    
    func configure(for character: CharacterDetails) {
        nameLabel.text = character.name
        
        if let url = character.imageURL {
            iconView.kf.setImage(with: url)
        } else {
            iconView.image = nil
        }
    }
}

extension CharacterDetails {
    var imageURL: URL? {
        guard let image = image else {
            return nil
        }
        
        return URL(string: image)
    }
}
