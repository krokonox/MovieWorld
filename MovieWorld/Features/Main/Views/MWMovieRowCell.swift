//
//  MWRowCell.swift
//  MovieWorld
//
//  Created by Admin on 25/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MWMovieRowCell: UICollectionViewCell {
   
    var movies: [MWMovie] = [] {
        didSet {
            self.needsUpdateConstraints()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
