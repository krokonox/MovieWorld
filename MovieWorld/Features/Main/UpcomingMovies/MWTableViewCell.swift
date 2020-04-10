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
    
    private var edgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    private var itemSize = CGSize(width: 130, height: 180)
    private var category: String = ""
    private var movies: [MWMovie] = [] {
        didSet {
            self.collection.collectionView.reloadData()
        }
    }

    lazy var collection: MWCollectionView = {
        let collectionView = MWCollectionView(frame: frame, itemSize: self.itemSize)
        
        collectionView.collectionView.delegate = self
        collectionView.collectionView.dataSource = self
        collectionView.redButton.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
        return collectionView
    }()

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell")
        self.contentView.addSubview(self.collection)
        self.collection.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions

    // MARK: - Functions
    
    func set(movies: [MWMovie], title: String, category: String) {
        self.movies = movies
//        self.collection.tit.text = NSLocalizedString(title, comment: "")
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
        self.collection.collectionView.reloadData()
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
