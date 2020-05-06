//
//  MWMoviesListViewController.swift
//  MovieWorld
//
//  Created by Admin on 13/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class MWMoviesListViewController: UIViewController {
    
    // MARK: - Variables
    
    private let activityIndicator = UIActivityIndicatorView()
    private let dispatch = DispatchGroup()
    
    private var edgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5) 
    private var sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 5, right: 15)
    private var itemSize = CGSize(width: 105, height: 26)
    private var category: String = ""

    var moviesToShow: [MWMovie] = []
    var movies: [MWMovie] = [] 
        
    let genres = MWSys.sh.genres
    
    // MARK: - Gui Variables
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = 120
        tv.separatorStyle = .none
        tv.register(TableViewCell<MovieDetailViewLayout>.self,
                    forCellReuseIdentifier: TableViewCell<MovieDetailViewLayout>.reuseIdentifier)
        
        return tv
    }()
    
    private lazy var header = UIView(frame: CGRect(x: 0, y: 0,
                                                   width: tableView.frame.width,
                                                   height: 80))
    
    private lazy var collectionView: UICollectionView = {
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
        cv.dataSource = self
        cv.delegate = self
        cv.allowsMultipleSelection = true
        cv.reloadData()
        return cv
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshCntrl = UIRefreshControl()
        refreshCntrl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshCntrl.addTarget(self, action: #selector(self.refresh),
                                 for: UIControl.Event.valueChanged)
        return refreshCntrl
    }()

    // MARK: - UI Functions
    
    private func setupViews() {
        self.view.addSubview(tableView)
        self.tableView.addSubview(refreshControl)
        self.tableView.tableHeaderView = header
        self.header.addSubview(collectionView)
    }
    
    private func setConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setConstraints()
    }
    
    // MARK: - Private Functions
    
    private func initRequest(path: String) {
        self.dispatch.enter()
        MWNetwork.sh.request(urlPath: path,
                          successHandler: { [weak self] (_ response: MWApiResults) in
                            self?.movies = response.results
                            self?.activityIndicator.stopAnimating()
                            self?.refreshControl.endRefreshing()
                            self?.tableView.reloadData()
                            self?.dispatch.leave()
        }) { [weak self] (error) in
            self?.showError(error.localizedDescription)
            self?.dispatch.leave()
        }
    }
    
    private func showMoviesByGenre(genre: String) {
        for movie in self.movies {
            let genres = movie.genres.map { $0 }
            if genres.contains(genre) {
                self.moviesToShow.append(movie)
            }
        }
    }
    
    private func hideMoviesByGenre(genre: String) {
        for movie in self.moviesToShow {
            let genres = movie.genres.map { $0 }
            if genres.contains(genre) {
                if let movieToDeleteIndex =  moviesToShow.firstIndex(of: movie) {
                    self.moviesToShow.remove(at: movieToDeleteIndex)
                }
            }
        }
    }

    private func updateCellWith(row: [MWMovieCell]) {
        self.collectionView.reloadData()
    }
    
    private func showError(_ error: String) {
        self.alert(message: error.description, title: "")
    }
    
    // MARK: - Functions
    
    func set(movies: [MWMovie], category: String) {
        self.movies = movies
        self.category = category
    }
    
    @objc func refresh(sender: AnyObject) {
        self.activityIndicator.startAnimating()
        self.initRequest(path: self.category)
    }
}

// MARK: - TableView Extension

extension MWMoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.moviesToShow.isEmpty {
            return self.movies.count
        } else {
            return self.moviesToShow.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell<MovieDetailViewLayout>.reuseIdentifier)
        
        if let cell = cell as? TableViewCell<MovieDetailViewLayout> {
            if moviesToShow.isEmpty {
                cell.layout.set(movie: movies[indexPath.row])
                
            } else {
                cell.layout.set(movie: moviesToShow[indexPath.row])
            }
            cell.selectionStyle = .none
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MWI.sh.push(vc: MWMovieDetailViewController(movie: movies[indexPath.row]) )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

// MARK: - CollectionView Extension

extension MWMoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWCollectionViewGenreCell.reuseIdentifier, for: indexPath)
        
         if let cell = cell as? MWCollectionViewGenreCell {
            if let genre = self.genres[indexPath.row].name {
                cell.set(text: genre)
            } else {
                cell.set(text: "-")
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if let cell = cell as? MWCollectionViewGenreCell {
            cell.backgroundColor = UIColor.init(named: "RedColor")?.withAlphaComponent(0.6)
            self.showMoviesByGenre(genre: cell.collectionViewCellTitle.text ?? "")
            self.tableView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if let cell = cell as? MWCollectionViewGenreCell {
            cell.backgroundColor = UIColor(named: "RedColor")
            self.hideMoviesByGenre(genre: cell.collectionViewCellTitle.text!)
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets
    }
}
