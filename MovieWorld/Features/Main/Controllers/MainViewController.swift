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
    
    var movies: [String: [MWMovie]] = [:] {
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
            for path in paths {
                initRequest(path: path)
        }
    }
    
    private func initRequest(path: URLPaths) {
        MWNetwork.request(urlPath: path.rawValue, successHandler: { [weak self] (_ response: MWApiResults) in
            self?.movies[path.description] = response.results
        }) { [weak self] (error) in
            self?.showError(error.localizedDescription)
        }
        self.tableView.reloadData()
        self.activityIndicator.stopAnimating()
        self.refreshControl.endRefreshing()
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
        let movieCategory = paths[indexPath.row].description
        if movies[movieCategory] != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MWTableViewCell
            cell.set(movies: movies[movieCategory]!, title: movieCategory)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  }
