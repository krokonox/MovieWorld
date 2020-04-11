//
//  MWCollectionViewDataManager.swift
//  MovieWorld
//
//  Created by Admin on 11/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol DataManager {
    associatedtype DataType
    
    func itemCount() -> Int
    func itemCount(section: Int) -> Int?
    func sectionCount() -> Int
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> DataType
    func append(newData: [DataType], toSection: Int)
    
    func clearData()
}

final class FlatArrayDataManager<T>: DataManager {
    
//    typealias DataType = T
    
    private var data: [T]
    
    init(data: [T]) {
        self.data = data
    }
    
    convenience init() {
        self.init(data: [T]())
    }
    
    func itemCount() -> Int {
        data.count
    }
    
    func itemCount(section: Int) -> Int? {
        guard section < 1 else {
            return nil
        }
        return itemCount()
    }
    
    func sectionCount() -> Int {
        return 1
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> T {
        data[indexPath.row]
    }
    
    func append(newData: [T], toSection: Int) {
        data.append(contentsOf: newData)
    }
    
    func clearData() {
        data.removeAll()
    }
    
}
