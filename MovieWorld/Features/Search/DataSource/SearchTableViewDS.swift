//
//  SearchTableViewDS.swift
//  MovieWorld
//
//  Created by Admin on 11/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class SearchTableViewDS: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var movies: [MWMovie] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell<MovieDetailViewLayout>.reuseIdentifier)
        
        if let cell = cell as? TableViewCell<MovieDetailViewLayout> {
            cell.layout.set(movie: movies[indexPath.row])
            cell.selectionStyle = .none
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MWI.sh.push(vc: MWMovieDetailViewController(movie: movies[indexPath.row]) )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

