//
//  MWCollectionViewDataSource.swift
//  MovieWorld
//
//  Created by Admin on 06/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class SimpleCollectionViewDataSource<ViewModel>: NSObject, UICollectionViewDataSource {
    
    typealias CellConfigurator = (ViewModel, UICollectionViewCell) -> Void
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    private var cellViewModels: [ViewModel]
    
    // MARK: - Initializers
    
    init(cellViewModels: [ViewModel], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.cellViewModels = cellViewModels
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    // MARK: - Collection view data source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = cellViewModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(viewModel, cell)
        return cell
    }
}



