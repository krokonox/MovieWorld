//
//  MWCollectionViewGenreCell.swift
//  MovieWorld
//
//  Created by Admin on 21/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWCollectionViewGenreCell: UICollectionViewCell {
    
    // MARK: - Variables
    
    lazy var collectionViewCellTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Private functions

    private func setupView() {
        self.addSubview(self.collectionViewCellTitle)
        self.setUpConstrants()
        
        self.backgroundColor = UIColor(named: "RedColor")
        self.layer.cornerRadius = 5.0
    }
    
    private func setUpConstrants() {
        self.collectionViewCellTitle.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    
    func set(text: String) {
        self.collectionViewCellTitle.text = text
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatal error ")
    }
}
