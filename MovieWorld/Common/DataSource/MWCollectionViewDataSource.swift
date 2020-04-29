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


final class MovieCellPopulator: CollectionViewCellPopulator {
    typealias DataType = MWGenericCollectionViewCellModel

    func populate(collectionView: UICollectionView, indexPath: NSIndexPath, data: MovieCellPopulator.DataType) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as? MWMovieCell {
            cell.item = data
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}











final class CollectionViewDataSource<Model>: NSObject, UICollectionViewDataSource {
    typealias CellConfigurator = (Model, UICollectionViewCell) -> Void
    var models: [Model] = []
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(model, cell)
        return cell
    }
}

extension CollectionViewDataSource where Model == MWMovie {
    func make() -> CollectionViewDataSource {
        return CollectionViewDataSource(reuseIdentifier: "cell", cellConfigurator: { item, cell in
            (cell as? MWMovieCell)?.configure(item: MWGenericCollectionViewCellModel(movie: item))
        })
    }
}
