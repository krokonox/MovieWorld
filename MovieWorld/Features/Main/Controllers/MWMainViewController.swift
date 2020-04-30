//
//  MainViewController.swift
//  MovieWorld
//
//  Created by Admin on 20/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class MWMainViewController: MWViewController {
    
    // MARK: - Variables
    
    private let paths = URLPaths.allCases
    private let activityIndicator = UIActivityIndicatorView()
    private let dispatch = DispatchGroup()
    var movies: [String: [MWMovie]] = [:]
    
    // MARK: - Gui Variables
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.addSubview(self.refreshControl)
        tv.rowHeight = 305
        tv.register(MWTableViewCell.self, forCellReuseIdentifier: MWTableViewCell.reuseIdentifier)
        tv.separatorStyle = .none
    
        return tv
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshCntrl = UIRefreshControl()
        refreshCntrl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshCntrl.addTarget(self, action: #selector(refresh),
                               for: UIControl.Event.valueChanged)
        return refreshCntrl
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Main",
                                       comment: "")
        
        self.view.addSubview(tableView)
        self.makeConstraints()
        self.fetchMovies()
    }
    
    // MARK: - Private functions

    private func initRequest(path: URLPaths) {
        self.dispatch.enter()
        MWNet.sh.request(urlPath: path.rawValue,
                             successHandler: { [weak self] (_ response: MWApiResults) in
                                self?.movies[path.description] = response.results
                                self?.dispatch.leave()
        }) { [weak self] (error) in
            self?.showError(error.localizedDescription)
        }
    }
    
    private func makeConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func fetchMovies() {
        self.activityIndicator.startAnimating()
        
        for path in self.paths {
            self.initRequest(path: path)
        }
        
        self.dispatch.notify(queue: .main) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }
    
    private func showError(_ error: String) {
        print(error)
    }
    
    // MARK: - Functions
    
    @objc func refresh(sender: AnyObject) {
        self.fetchMovies()
    }
    
    @objc func reloadMovieCategory(_ sender: UIButton) {
        let cellPosition = sender.convert(sender.bounds.origin, to: tableView)
        
        if let indexPath = self.tableView.indexPathForRow(at: cellPosition) {
            let rowIndex = indexPath.row
            self.initRequest(path: self.paths[rowIndex])
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - TableView Extension

extension MWMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCategory = self.paths[indexPath.row].description
        let cell = self.tableView.dequeueReusableCell(withIdentifier: MWTableViewCell.reuseIdentifier, for: indexPath) as! MWTableViewCell
        
        // in MWTableViewCell
        cell.reloadButton.addTarget(self, action: #selector(reloadMovieCategory(_:)), for: .touchUpInside)
        
        if let movies = movies[movieCategory] {
            cell.set(movies: movies, title: movieCategory, category: paths[indexPath.row].rawValue)
            return cell
        } else {
            cell.set(movies: [], title: "", category: paths[indexPath.row].rawValue)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
}
