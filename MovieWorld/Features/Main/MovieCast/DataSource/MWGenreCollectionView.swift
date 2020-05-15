//
//  MWGenreCollectionView.swift
//  MovieWorld
//
//  Created by Admin on 13/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

final class MWGenreCollectionView: UIView {
    
    // MARK: - Variables
    
    private var sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 5, right: 15)
    private var itemSize = CGSize(width: 105, height: 26)
    
    // MARK: - Gui Variables
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = self.sectionInset
        layout.itemSize = self.itemSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(MWCollectionViewGenreCell.self,
                    forCellWithReuseIdentifier: MWCollectionViewGenreCell.reuseIdentifier)
        cv.allowsMultipleSelection = true
        cv.reloadData()
        return cv
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("failed to initialize")
    }
    
    // MARK: - Private Functions
    
    private func setup() {
        self.addSubview(collectionView)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
