//
//  MWTableViewCell.swift
//  MovieWorld
//
//  Created by Admin on 26/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class MWTableViewCell: UITableViewCell {
    
    //--MARK: Variables
    
    let cellID = "MWTableViewCell"
    private var edgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    private var sectionInset = UIEdgeInsets(top: 30, left: 15, bottom: 10, right: 15)
    private var itemSize = CGSize(width: 130, height: 180)
    private var buttonSize = CGSize(width: 62, height: 25)
    private var category: String = ""
    private var movies: [MWMovie] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = self.sectionInset
        layout.itemSize = self.itemSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 10.0
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
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
        button.addTarget(self, action: #selector(self.pushVC), for: .touchUpInside)
        
        return button
    }()
    
    lazy var reloadButton: MWRedButton = {
        let button = MWRedButton()
        button.setTitle("reload", for: .normal)
        button.backgroundColor = UIColor.init(named: "RedColor")?.withAlphaComponent(0.6)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell")
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(redButton)
        self.contentView.addSubview(reloadButton)
        
        self.setupConstraints()
    }
    
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
    
    func set(movies: [MWMovie], title: String, category: String) {
        self.movies = movies
        self.titleLabel.text = NSLocalizedString(title, comment: "")
        self.category = category
    }
    
    @objc func pushVC() {
        let vc = MWMoviesListViewController()
        vc.set(movies: self.movies, category: self.category)
        MWI.sh.push(vc: vc)
    }
}

// MARK: - CollectionView Extension

extension MWTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCellWith(row: [MWMovieCell]) {
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MWMovieCell {
            let movie = MWGenericCollectionViewCellModel(movie: movies[indexPath.row])
            cell.item = movie
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        MWI.sh.push(vc: MWMovieDetailViewController(movie: self.movies[indexPath.row]))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets
    }
    
}
