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
    
    var movies: [MWMovie] = [] {
        didSet {}
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = 120
        tv.separatorStyle = .none
        tv.register(MWMovieDetailCell.self, forCellReuseIdentifier: "cell")
        
        return tv
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - Functions
    
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
