//
//  MWTableViewCell.swift
//  MovieWorld
//
//  Created by Admin on 26/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class MWTableViewCell: UITableViewCell {
    
    var collectionView = UICollectionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    
}

extension MWTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
     
        return 1
    }
    
}
