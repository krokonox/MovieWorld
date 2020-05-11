//
//  SearchViewController.swift
//  MovieWorld
//
//  Created by Admin on 20/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class MWSearchViewController: MWViewController {
    
    // MARK: - Variables
    
    private let dataSource = SearchTableViewDS()
    
    var movies: [MWMovie] = [] {
        didSet {
            self.setupUI()
        }
    }
    
    // MARK: - Gui variables
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        return search
    }()
    
    private lazy var rightBarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "settings"), for: .normal)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self.dataSource
        return tv
    }()
    
    // MARK: - UI Functions
    
    private func setupConstraints() {
        
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           self.title = "Search".localized
           MWI.sh.push(vc: UIViewController())
       }

    // MARK: - Private Functions
    
    private func searchMovie(name: String) {
        MWNet.sh.request(urlPath: Endpoints.search(searchText: name).path,
                         successHandler: { [weak self] (_ response: MWApiResults) in
                            self?.movies = response.results
        }) { [weak self] (error) in
            self?.alert(message: error.description)
        }
    }
    
    private func search() {
        
    }
    
    // MARK: - Functions

    func set() {
        self.dataSource.movies = movies
    }
}
