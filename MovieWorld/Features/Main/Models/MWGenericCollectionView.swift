//
//  MWGenericCollectionView.swift
//  MovieWorld
//
//  Created by Admin on 01/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MWGenericCollectionView: UICollectionViewFlowLayout {
    
    private var edgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    internal var sectionInsetVar = UIEdgeInsets(top: 30, left: 15, bottom: 10, right: 15)
    internal var itemSizeVar = CGSize(width: 130, height: 180)
    private var firstSetupDone = false

//    override func prepare() {
//        super.prepare()
//        if !firstSetupDone {
//            setup()
//            firstSetupDone = true
//        }
//    }
//
    override init() {
        super.init()
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = self.sectionInsetVar
        layout.itemSize = self.itemSizeVar
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 10.0
    }
}
