//
//  CharacterListViewController.swift
//  RickAndMortyApp
//
//  Created by Joakim Back on 2019-07-02.
//  Copyright © 2019 Joakim Back. All rights reserved.
//

import Foundation
import Kingfisher
import PromiseKit
import UIKit

class CharacterListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
    }
    
    func configure(for character: CharacterDetails) {
        cardView.layer.cornerRadius = 16.0
        cardView.layer.masksToBounds = true
        
        shadowView.layer.shadowOpacity = 0.25
        shadowView.layer.shadowRadius = 16.0
        shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        shadowView.layer.shouldRasterize = true
        shadowView.layer.rasterizationScale = 2.0

        nameLabel.text = character.name
        
        if let url = character.imageURL {
            imageView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
            imageView.kf.setImage(with: url)
        }
    }
}

class CharacterListViewController: UICollectionViewController {
    var page: Int = 0
    var isLoading = false
    var characters: [CharacterDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNextPage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
            layout.minimumLineSpacing = 24.0
            layout.minimumInteritemSpacing = 12.0
            layout.set(columns: 2, heightRatio: 1.618)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        
        // Fetch the next page if user scrolls to the end
        if index == (characters.count - 1), isLoading == false {
            fetchNextPage()
        }
        
        // Configure cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterListCell", for: indexPath) as! CharacterListCell
        cell.configure(for: characters[index])
        cell.layer.masksToBounds = false
        return cell
    }
}

extension CharacterListViewController {
    private func fetchNextPage() {
        page = page + 1
        isLoading = true
        
        firstly {
            Service.shared.fetchCharacters(for: page)
            }.done { characters in
                self.characters = self.characters + characters
            }.catch { error in
                // Handle errors
            }.finally {
                self.isLoading = false
                self.collectionView.reloadData()
        }
    }
}
