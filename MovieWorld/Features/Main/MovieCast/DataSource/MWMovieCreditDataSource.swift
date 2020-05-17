//
//  MWMovieCreditDataSource.swift
//  MovieWorld
//
//  Created by Admin on 09/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMovieCreditDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var credits: [Cast] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  CreditTableViewCell<MWMovieCreditCell>.reuseIdentifier, for: indexPath)
        if let cell = cell as? CreditTableViewCell<MWMovieCreditCell> {
            let creditId = self.credits[indexPath.row].id
            cell.selectionStyle = .none
            cell.layout.creditId = creditId
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let credit = credits[indexPath.row].id
        MWI.sh.push(vc: MWMovieCreditDetailViewController(castId: credit))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
