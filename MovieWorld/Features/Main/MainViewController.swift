//
//  MainViewController.swift
//  MovieWorld
//
//  Created by Admin on 20/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    let tableView = UITableView()
    
    var cellId = "cellId"
    
    var movies: [String: [MWMovie]] = ["0" : [MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "search")),
                                              MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "search")),
                                              MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "search")) ],
        
                                       "1" : [MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "search")),
                                              MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "search")),
                                              MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "search")) ],
                                       
                                       "2" : [MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "search")),
                                              MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "search")),
                                              MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "search")) ]]
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = .red
        collection.isScrollEnabled = true
        return collection
    }()
    
    func set() {
        let mwr = MWMovieRowCell()
        mwr.movies = movies["0"]!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        setupTableView()
        setUpCollectionView()
        
        self.title = "Main"
        self.view.backgroundColor = .white
        
        MWI.sh.push(vc: UIViewController())
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MWMovieRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.reloadData()
        self.collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(305)
            make.left.right.equalToSuperview()
        }
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
