//
//  MWMovieCastViewController.swift
//  MovieWorld
//
//  Created by Admin on 06/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMovieCreditListViewController: UIViewController {
    
    // MARK: - Variables
    
    private let activityIndicator = UIActivityIndicatorView()
    private let dispatch = DispatchGroup()
    private let dataSource = MWMovieCreditDataSource()
    
    private var edgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5) 
    private var sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 5, right: 15)
    private var itemSize = CGSize(width: 105, height: 26)
    private var category: String = ""
    
    var credits: [Cast] = [] {
        didSet {
            setupUI()
        }
    }

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .plain)
        tv.delegate = self.dataSource
        tv.dataSource = self.dataSource
        tv.rowHeight = 90
        tv.separatorStyle = .none
        tv.register(CreditTableViewCell<MWMovieCreditCell>.self,
                    forCellReuseIdentifier: CreditTableViewCell<MWMovieCreditCell>.reuseIdentifier)
        return tv
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - UI Functions
    
    private func setConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupUI() {
        self.title = "Cast".localized
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.setConstraints()
    }
    
    // MARK: - Setter
    
    func set(credits: [Cast]) {
        self.dataSource.credits = credits
    }
    
    // MARK: - Functions
    
    private func showError(_ error: String) {
        print(error)
    }
}
