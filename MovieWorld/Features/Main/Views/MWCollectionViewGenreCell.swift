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
        return label
    }()
    
    // MARK: - Private functions

    private func setupView() {
        self.backgroundColor = UIColor.init(named: "RedColor")?.withAlphaComponent(0.6)
        self.layer.cornerRadius = 5.0
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
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatal error ")
    }
}
