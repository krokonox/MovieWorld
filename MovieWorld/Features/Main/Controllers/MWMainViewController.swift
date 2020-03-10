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

class MWMainViewController: UIViewController {
    
    let cellId = "cellId"
    let MWNetwork: MWNet = MWNet.sh
    let paths = URLPaths.allCases
    let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView()
    let refreshControl = UIRefreshControl()
    let dispatchGroup = DispatchGroup()
    
    var movies: [String: [MWMovie]] = [:] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setRefresh()
        self.view.addSubview(tableView)
        
        self.setupTableView()
        
        self.title = "Main"
        self.view.backgroundColor = .white
        MWI.sh.push(vc: UIViewController())
        
    }
    
    private func setupTableView() {
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
        refreshControl.addTarget(self, action: #selector(refresh),
                                 for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func initRequest(path: URLPaths) {
        dispatchGroup.enter()
        MWNetwork.request(urlPath: path.rawValue,
                          successHandler: { [weak self] (_ response: MWApiResults) in
                            self?.movies[path.description] = response.results
        }) { [weak self] (error) in
            self?.showError(error.localizedDescription)
        }
        dispatchGroup.leave()
    }
    
    @objc func refresh(sender:AnyObject) {
        movies = [:]
        activityIndicator.startAnimating()
        for path in paths {
            initRequest(path: path)
        }
        self.dispatchGroup.notify(queue: .main) { [weak self] in
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func showError(_ error: String) {
        print(error)
    }
}

extension MWMainViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            initRequest(path: paths[indexPath.row])
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MWTableViewCell
            cell.set(movies: movies[movieCategory]!, title: movieCategory)
            return cell
//            let cell = tableView.dequeueReusableCell(withIdentifier: "reloadCell", for: indexPath) as! MWReloadTableViewCell
//            cell.button.addTarget(self,
//                                  action: #selector(reloadMovieCategpry),
//                                  for: .allTouchEvents)
//            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}
