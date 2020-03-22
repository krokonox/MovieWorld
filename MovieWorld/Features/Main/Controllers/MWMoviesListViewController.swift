//
//  MWMoviesListViewController.swift
//  MovieWorld
//
//  Created by Admin on 13/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MWMoviesListViewController: UIViewController {
    
    // MARK: - Variables
    
    private var edgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
    private var sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 5, right: 15)
    private var itemSize = CGSize(width: 105, height: 26)
    let genres = MWSys.sh.genres
    var movies: [MWMovie] = [] {
        didSet {}
    }
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .plain)
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tv.frame.width, height: 80))
        header.addSubview(collectionView)
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = 120
        tv.separatorStyle = .none
        tv.tableHeaderView = header
        tv.register(MWMovieDetailCell.self, forCellReuseIdentifier: "cell")
        
        return tv
    }()
 
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = self.sectionInset
        layout.itemSize = self.itemSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(MWCollectionViewGenreCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.configureCollectionView()
        self.setConstraints()
        
    }
    
    // MARK: - Functions
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        collectionView.backgroundColor = .white
    }
    
    private func setConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func set(movies: [MWMovie]) {
        self.movies = movies
    }
}

// MARK: - TableView Extension

extension MWMoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MWMovieDetailCell
            else {
                return UITableViewCell()
        }
        
        cell.set(movie: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

// MARK: - CollectionView Extension

extension MWMoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCellWith(row: [MWMovieCell]) {
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MWCollectionViewGenreCell {
            if let genre = genres[indexPath.row].name {
                cell.set(text: genre)
            } else {
                cell.set(text: "...")
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets
    }
    
}
