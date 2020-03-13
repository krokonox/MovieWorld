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
    let dispatch = DispatchGroup()
    
    var movies: [String: [MWMovie]] = [:] {
        didSet {}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main"
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.setRefresh()
        self.setupTableView()
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
        dispatch.enter()
        MWNetwork.request(urlPath: path.rawValue,
                          successHandler: { [weak self] (_ response: MWApiResults) in
                            self?.movies[path.description] = response.results
        }) { [weak self] (error) in
            self?.showError(error.localizedDescription)
        }
        dispatch.leave()
    }
    
    @objc func refresh(sender:AnyObject) {
        activityIndicator.startAnimating()
        
        for path in paths {
            initRequest(path: path)
        }

        self.dispatch.notify(queue: .main) { [weak self] in
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc func reloadMovieCategory(_ sender: UIButton) {
        let cellPosition = sender.convert(sender.bounds.origin, to: tableView)
        
        if let indexPath = tableView.indexPathForRow(at: cellPosition) {
            let rowIndex = indexPath.row
            initRequest(path: paths[rowIndex])
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    private func showError(_ error: String) {
        print(error)
    }
}

extension MWMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCategory = paths[indexPath.row].description
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MWTableViewCell
        
        cell.reloadButton.addTarget(self, action: #selector(reloadMovieCategory(_:)), for: .allTouchEvents)
        
        if let movies = movies[movieCategory] {
            cell.set(movies: movies, title: movieCategory)
            return cell
        } else {
            cell.set(movies: [], title: "")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
}
