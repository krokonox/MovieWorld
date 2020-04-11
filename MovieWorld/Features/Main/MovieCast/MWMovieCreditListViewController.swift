//
//  MWMovieCastViewController.swift
//  MovieWorld
//
//  Created by Admin on 06/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMovieCreditListViewController: UIViewController {
    
    var credits: [Cast] = [] {
        didSet {
            setupUI()
        }
    }
    
    private let activityIndicator = UIActivityIndicatorView()
    private let dispatch = DispatchGroup()
    
    private var edgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)  // Not sure about the best variable order here
    private var sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 5, right: 15)
    private var itemSize = CGSize(width: 105, height: 26)
    private var category: String = ""

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .plain)
        tv.addSubview(self.refreshControl)
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = 90
        tv.separatorStyle = .none
        tv.register(CreditTableViewCell<MWMovieCreditCell>.self, forCellReuseIdentifier: "cell")
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
        self.setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupUI() {
        self.title = "Cast"
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
//        self.tableView.addSubview(refreshControl)
        self.setConstraints()
    }
    // MARK: - Functions
    
    func set(credits: [Cast]) {
        self.credits = credits
    }
    
    @objc func refresh(sender: AnyObject) {
        self.activityIndicator.startAnimating()
//        self.initRequest(path: self.category)
        self.dispatch.notify(queue: .main) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }
    
    private func showError(_ error: String) {
        print(error)
    }
}

// MARK: - TableView Extension

extension MWMovieCreditListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CreditTableViewCell<MWMovieCreditCell>
            else {
                return UITableViewCell()
        }
        cell.layout.creditId = self.credits[indexPath.row].id
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



