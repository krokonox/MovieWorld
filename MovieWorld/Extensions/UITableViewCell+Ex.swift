//
//  UITableViewCell+Ex.swift
//  MovieWorld
//
//  Created by Admin on 30/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

extension UITableViewCell { // How can i not duplicate these extensions?
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
