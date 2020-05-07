//
//  CategoryViewController.swift
//  MovieWorld
//
//  Created by Admin on 20/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class MWCategoryViewController: MWViewController {
    
    // MARK: - Variables
    
    let cellText = "Top 250 films"
    let cellID = "cell"
    
    // MARK: - Gui Variables
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = 305
        tv.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tv.separatorStyle = .none
        
        return tv
    }()
    
    // MARK: - App lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makeConstraints()
        self.title = NSLocalizedString("Category",
                                       comment: "")
    }
    
    // MARK: - Constraints
    
    func makeConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - TableView Extension

extension MWCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = self.cellText
        return cell
    }
}
