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
    
    // MARK: - Variables

    let cellId = "cellId"
    let paths = URLPaths.allCases
    let MWNetwork: MWNet = MWNet.sh
    let activityIndicator = UIActivityIndicatorView()
    let refreshControl = UIRefreshControl()
    let dispatch = DispatchGroup()
    
    var movies: [String: [MWMovie]] = [:] {
        didSet {}
    }
  
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = 305
        tv.register(MWTableViewCell.self, forCellReuseIdentifier: "cell")
        tv.separatorStyle = .none
    
        return tv
    }()
  
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main"
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.setRefresh()
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
    }
    
    // MARK: - Private functions
    
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
                            self?.dispatch.leave()
        }) { [weak self] (error) in
            self?.showError(error.localizedDescription)
        }
    }
    
    // MARK: - Functions
    
    @objc func refresh(sender:AnyObject) {
        activityIndicator.startAnimating()
        
        for path in paths {
            initRequest(path: path)
        }

        self.dispatch.notify(queue: .main) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
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

// MARK: - TableView Extension

extension MWMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCategory = paths[indexPath.row].description
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MWTableViewCell
        
        cell.reloadButton.addTarget(self, action: #selector(reloadMovieCategory(_:)), for: .touchUpInside)
        
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
