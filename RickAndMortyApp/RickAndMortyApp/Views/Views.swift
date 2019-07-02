//
//  Views.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-02.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Foundation
import UIKit

class CardView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 16.0
        layer.masksToBounds = true
    }
}

class ShadowView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        layer.shadowRadius = 16.0
        layer.shadowOpacity = 0.25
    }
}

class IconView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .lightGray
        layer.cornerRadius = 4.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
    }
}
