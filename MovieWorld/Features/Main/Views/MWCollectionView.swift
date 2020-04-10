//
//  MWCollectionView.swift
//  MovieWorld
//
//  Created by Admin on 08/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

final class MWCollectionView: UIView {
    
    private var edgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    private var sectionInset = UIEdgeInsets(top: 30, left: 15, bottom: 10, right: 15)
    var itemSize: CGSize {
        didSet {
            self.setup()
            self.collectionView.reloadData()
        }
    }
    private var buttonSize = CGSize(width: 62, height: 25)
    private var category: String = ""
    private var items: [MWGenericCollectionViewCellModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
     lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = self.sectionInset
        layout.itemSize = self.itemSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 10.0
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(MWMovieCell.self, forCellWithReuseIdentifier: "cell")
        cv.reloadData()
        return cv
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        title.textAlignment = .left
        return title
    }()
    
    lazy var redButton: MWRedButton = {
        let button = MWRedButton()
        button.setTitle("All -> ", for: .normal)
//        button.addTarget(self, action: #selector(self.pushVC), for: .touchUpInside)
        return button
    }()
    
    lazy var reloadButton: MWRedButton = {
        let button = MWRedButton()
        button.setTitle("reload", for: .normal)
        button.backgroundColor = UIColor.init(named: "RedColor")?.withAlphaComponent(0.6)
        return button
    }()
 
    // MARK: - Private functions

    private func setupConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview()
            make.top.equalTo(collectionView).offset(12)
        }
        self.redButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.width.height.equalTo(buttonSize)
            make.top.equalTo(collectionView).offset(14)
        }
        self.reloadButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(90)
            make.width.height.equalTo(buttonSize)
            make.top.equalTo(collectionView).offset(14)
        }
    }
    
    // MARK: - Functions
    
    func set(items: [MWGenericCollectionViewCellModel],
             title: String,
             category: String,
             itemSize: CGSize) {
        self.items = items
        self.titleLabel.text = NSLocalizedString(title, comment: "")
        self.category = category
        self.itemSize = itemSize
    }
    
    private func setup() {
        self.addSubview(collectionView)
        self.addSubview(titleLabel)
        self.addSubview(redButton)
        self.addSubview(reloadButton)
        
        self.setupConstraints()
    }
    
    init(frame: CGRect, itemSize: CGSize) {
        self.itemSize = itemSize
        super.init(frame: frame)
        self.setup()
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("failed to initialize")
    }
}

