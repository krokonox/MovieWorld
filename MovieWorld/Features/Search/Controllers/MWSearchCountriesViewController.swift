//
//  MWSearchCountriesViewController.swift
//  MovieWorld
//
//  Created by Admin on 11/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class MWSearchCountriesViewController: MWViewController {
    
    // MARK: - Variables
    
    let tableViewDataSource = SearchCountriesTableViewDS()
    
    // MARK: - Gui variables
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self.tableViewDataSource
        tv.delegate = self.tableViewDataSource
        tv.register(MWCountryTableViewCell.self, forCellReuseIdentifier: MWCountryTableViewCell.reuseIdentifier)
        tv.allowsMultipleSelection = true
        return tv
    }()
    
    // MARK: - UI Functions
    
    private func setup() {
        self.view.addSubview(tableView)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    // MARK: - Private Functions
}
