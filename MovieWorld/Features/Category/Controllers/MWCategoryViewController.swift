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
    let genres: [GenreModel] = MWSys.sh.genres
    
    // MARK: - Gui Variables
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = 40
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
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func fetchMovieList(with genreId: Int16) {
        MWNetwork.sh.request(urlPath: "discover/movie",
                            parameters: ["with_genres" : "\(genreId)"],
                             successHandler: { [weak self] (_ response: MWApiResults) in
                                self?.pushVC(movies: response.results)
        }) { [weak self] (error) in
            self?.alert(message: error.description)
        }
    }
    
    private func pushVC(movies: [MWMovie]) {
        let vc = MWMoviesListViewController(movies: movies)
        MWI.sh.push(vc: vc)
    }
}

// MARK: - TableView Extension

extension MWCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = self.genres[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genreId = self.genres[indexPath.row].id
        self.fetchMovieList(with: genreId)
    }
}
