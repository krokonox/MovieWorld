//
//  GenreCollectionViewDS.swift
//  MovieWorld
//
//  Created by Admin on 13/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol GenreCollectionViewDelegate: class {
    func genreChosen(genre: Int16)
    func genreDeselected(genre: Int16)
}

class GenreCollectionViewDS: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let genres = MWSys.sh.genres
    weak var delegate: GenreCollectionViewDelegate?
    private var edgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWCollectionViewGenreCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? MWCollectionViewGenreCell {
            if let genre = self.genres[indexPath.row].name {
                cell.set(text: genre)
            } else {
                cell.set(text: "-")
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if let cell = cell as? MWCollectionViewGenreCell {
            cell.backgroundColor = UIColor.init(named: "RedColor")?.withAlphaComponent(0.6)
            self.delegate?.genreChosen(genre: genres[indexPath.row].id)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if let cell = cell as? MWCollectionViewGenreCell {
            cell.backgroundColor = UIColor(named: "RedColor")
            self.delegate?.genreDeselected(genre: genres[indexPath.row].id)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets
    }
}
