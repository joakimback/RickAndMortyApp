//
//  UICollectionViewFlowLayout+Rick.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-02.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewFlowLayout {
    func set(columns: Int, heightRatio: CGFloat) {
        guard let width = collectionView?.bounds.width else {
            return
        }
        
        let sectionSpacing = sectionInset.left + sectionInset.right
        let interimSpacing = CGFloat(max(0, columns - 1)) * minimumInteritemSpacing
        
        let itemWidth = (width - sectionSpacing - interimSpacing) / CGFloat(columns)
        let itemHeight = itemWidth * heightRatio
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
}
