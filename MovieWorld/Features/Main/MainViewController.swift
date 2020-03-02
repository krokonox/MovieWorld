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
    var paths = URLPaths.allCases
    
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
        for path in paths {
            initRequest(path: path)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 305
        tableView.register(MWTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func initRequest(path: URLPaths) {
        MWNetwork.request(urlPath: path, successHandler: { [weak self] (_ response: MWApiResults) in
            self?.movies[path.index!] = response.results
        }) { [weak self] (error) in
            self?.showError(error.localizedDescription)
        }
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
//        cell.movies = movies[indexPath.row]!
        print(movies)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
  }
