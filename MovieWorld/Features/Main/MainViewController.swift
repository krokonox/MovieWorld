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
    let activityIndicator = UIActivityIndicatorView()
    var refreshControl = UIRefreshControl()
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
        
        setRefresh()
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
        tableView.register(MWTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject) {
        if movies == [:] {
            for path in paths {
                initRequest(path: path)
            }
        } else {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    private func initRequest(path: URLPaths) {
        MWNetwork.request(urlPath: path, successHandler: { [weak self] (_ response: MWApiResults) in
            self?.movies[path.index!] = response.results
        }) { [weak self] (error) in
            self?.showError(error.localizedDescription)
        }
        self.tableView.reloadData()
    }
    
    private func showError(_ error: String) {
        print(error)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MWTableViewCell
        if movies.count >= 0 {
           cell.movies = movies[indexPath.row]!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  }
