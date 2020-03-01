//
//  MainViewController.swift
//  MovieWorld
//
//  Created by Admin on 20/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//
import Foundation
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let tableView = UITableView()
    var cellId = "cellId"
    var MWNetwork: MWNet = MWNet.sh
    var categories = URLPaths.allCases
    
    var movies: [Int: [MWMovie]] = [:] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        setupTableView()
        
        self.title = "Main"
        self.view.backgroundColor = .white
        MWI.sh.push(vc: UIViewController())
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 305
        tableView.reloadData()
      
        tableView.register(MWTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        for category in categories {
            initRequest(category: category)
            print(category.hashValue)
        }
    }
    
    private func initRequest(category: URLPaths) {
        MWNetwork.request(urlPath: category, successHandler: { [weak self] (_ response: MWApiResults) in
            self?.movies[category.hashValue] = response.results
        }, errorHandler: { [weak self] (error) in
            self!.showError(error.localizedDescription)
        })
    }
    
    private func showError(_ error: String) {
        print(error)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MWTableViewCell
        cell.movies = movies[indexPath.row]!

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
  }

//var movies: [Int: [MWMovie]] = [ 0 : [ MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: ""),
//                                   MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: ""),
//                                   MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: "")],
//
//                             1 : [ MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: ""),
//                                   MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: ""),
//                                   MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: "")],
//
//                             2 : [ MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: ""),
//                                   MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: ""),
//                                   MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: "") ],
//
//                             3 : [ MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: ""),
//                                   MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: ""),
//                                   MWMovie.init(title: "201", genre_ids: "Comedy", release_date: "2029", poster_path: "")]]
