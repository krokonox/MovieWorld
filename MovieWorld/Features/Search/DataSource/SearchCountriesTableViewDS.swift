//
//  SearchCountriesTableViewDS.swift
//  MovieWorld
//
//  Created by Admin on 14/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol UIImageViewDelegate: class {
    func hideImage(_ bool: Bool)
}

protocol CountriesTableViewControllerDelegate: class {
    func countrySelected(_ country: CountryModel)
    func countryDeselected(_ country: CountryModel)
}

class SearchCountriesTableViewDS: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var countries: [CountryModel] = MWSys.sh.countries
    weak var delegate: CountriesTableViewControllerDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MWCountryTableViewCell.reuseIdentifier)
        if let cell = cell as? MWCountryTableViewCell {
            cell.selectionStyle = .none
            cell.textLabel?.text = countries[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.countrySelected(countries[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
         self.delegate?.countryDeselected(countries[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
