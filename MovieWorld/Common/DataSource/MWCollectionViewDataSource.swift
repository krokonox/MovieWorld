//
//  MWCollectionViewDataSource.swift
//  MovieWorld
//
//  Created by Admin on 06/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewCellPopulator {
    associatedtype DataType
    
    func populate(collectionView: UICollectionView, indexPath: NSIndexPath, data: DataType) -> UICollectionViewCell
}

final class DataSource<T: DataManager, U: CollectionViewCellPopulator>: NSObject, UICollectionViewDataSource where U.DataType == T.DataType {
    
    internal let dataManager: T
    private let cellPopulator: U
    
    init(dataManager: T, cellPopulator: U) {
        self.dataManager = dataManager
        self.cellPopulator = cellPopulator
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataManager.sectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.itemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellPopulator.populate(collectionView: collectionView,
                                      indexPath: indexPath as NSIndexPath,
                                      data: dataManager.itemAtIndexPath(indexPath: indexPath as NSIndexPath))
    }
    
    
}


//final class MovieCellPopulator: CollectionViewCellPopulator {
//    typealias DataType = <#type#>
//
//    func populate(collectionView: UICollectionView, indexPath: NSIndexPath, data: MovieCellPopulator.DataType) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
//    }
//}






























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



