//
//  Views.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-02.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CardView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 16.0
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

@IBDesignable
class ShadowView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        layer.shadowRadius = 16.0
        layer.shadowOpacity = 0.25
    }
}

@IBDesignable
class IconView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        layer.cornerRadius = 4.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
    }
}

@IBDesignable
class GradientMaskImageView: UIImageView {
    @IBInspectable var gradientStart: CGFloat = 0.9 {
        didSet {
            layoutSubviews()
        }
    }
    
    var maskLayer: CAGradientLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if maskLayer == nil {
            maskLayer = CAGradientLayer()
            maskLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
            maskLayer.type = .axial
            layer.mask = maskLayer
        }
        
        maskLayer.frame = bounds
        maskLayer.startPoint = CGPoint(x: 0.0, y: gradientStart)
        maskLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
    }
}

@IBDesignable
class LetterpressView: UIView {
    var darkmode: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        layer.shadowRadius = 0.50
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        
        if darkmode {
            layer.shadowColor = UIColor.black.cgColor
        } else {
            layer.shadowColor = UIColor.white.cgColor
        }
    }
}

@IBDesignable
class ShadeView: UIView {
    var sublayer: CAGradientLayer!
    var darkmode: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if sublayer == nil {
            sublayer = CAGradientLayer()
            sublayer.type = .radial
            sublayer.opacity = 0.5
            layer.addSublayer(sublayer)
        }
        
        let white: CGFloat = (darkmode) ? 0.0: 1.0
        sublayer.colors = [
            UIColor(white: white, alpha: 0.0).cgColor,
            UIColor(white: white, alpha: 1.0).cgColor
        ]
        
        sublayer.frame = layer.bounds
        sublayer.startPoint = CGPoint(x: 0.5, y: 0.25)
        sublayer.endPoint = CGPoint(x: -0.5, y: 1.0)
    }
}
