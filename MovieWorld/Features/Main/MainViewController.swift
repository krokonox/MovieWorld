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
    
    var movies: [Int: [MWMovie]] = [ 0 : [ MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")),
                                           MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")),
                                           MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")) ],
        
                                     1 : [ MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")),
                                           MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")),
                                           MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")) ],
                                       
                                     2 : [ MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")),
                                           MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")),
                                           MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")) ],
                                     
                                     3 : [ MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")),
                                           MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")),
                                           MWMovie.init(title: "201", genre: "Comedy", year: 2029, image: #imageLiteral(resourceName: "movieImage")) ]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        setupTableView()
        
        self.title = "Main"
        self.view.backgroundColor = .white
        tableView.reloadData()
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
