//
//  SearchViewController.swift
//  MovieWorld
//
//  Created by Admin on 20/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class MWSearchViewController: MWViewController, SearchDelegate {
    
    // MARK: - Variables
    
    private let dataSource = SearchTableViewDS()
    
    var movies: [MWMovie] = [] {
        didSet {
            self.set()
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Gui variables
    
    private lazy var searchBar: UISearchController = {
        let search = UISearchController()
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.definesPresentationContext = true
        search.searchBar.placeholder = "Search Movie"
        return search
    }()
    
    private lazy var rightBarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self.dataSource
        tv.delegate = self.dataSource
        tv.rowHeight = 120
        tv.separatorStyle = .none
        tv.register(TableViewCell<MovieDetailViewLayout>.self,
                    forCellReuseIdentifier: TableViewCell<MovieDetailViewLayout>.reuseIdentifier)
        
        return tv
    }()
    
    // MARK: - UI Functions
    
    private func setupConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
        self.navigationItem.searchController = searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        
        self.setupConstraints()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
           super.viewDidLoad()
         
           self.title = "Search".localized
           self.setupUI()
       }

    // MARK: - Private Functions
    
    private func searchMovie(name: String) {
        MWNet.sh.request(urlPath: Endpoints.search.path,
                         parameters: ["query" : name],
                         successHandler: { [weak self] (_ response: MWApiResults) in
                            self?.movies = response.results
        }) { [weak self] (error) in
            DispatchQueue.main.async {
                 self?.alert(message: error.description)
            }
        }
    }
    
    private func set() {
        self.dataSource.movies = movies
    }
    
    func buttonPressed(_ movies: [MWMovie]) {
        self.movies = movies
        print(movies)
    }
    
    @objc func pushVC() {
        let vc = MWSearchFilterViewController()
        vc.delegate = self
        MWI.sh.push(vc: vc)
    }
}

extension MWSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = self.searchBar.searchBar.text, text.count > 3 else {
            return
        }
        self.searchMovie(name: text)
    }
}
