//
//  MWCollectionViewGenreCell.swift
//  MovieWorld
//
//  Created by Admin on 21/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class MWCollectionViewGenreCell: UICollectionViewCell {
    
    // MARK: - Variables
    
    private lazy var collectionViewCellTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .cyan
        return label
    }()
    
    // MARK: - Private functions

    private func setupView() {
        self.addSubview(collectionViewCellTitle)
        setUpConstrants()
    }
    
    private func setUpConstrants() {
        self.collectionViewCellTitle.snp.makeConstraints { (make) in
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
        self.backgroundColor = .white
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatal error ")
    }
}
