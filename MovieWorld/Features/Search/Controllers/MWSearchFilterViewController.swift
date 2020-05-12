//
//  MWSearchFilterViewController.swift
//  MovieWorld
//
//  Created by Admin on 11/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

protocol SearchDelegate: class {
    func buttonPressed(_ movies: [MWMovie])
}

class MWSearchFilterViewController: MWViewController {
    
    // MARK: - Variables
    
    weak var delegate: SearchDelegate?
    
    private var buttonSize = CGSize(width: 62, height: 25)
    private var year: String = ""
    private var voteMin: String = ""
    private var voteMax: String = ""
    
    var countries: [String] = []
    
    // MARK: - Gui variables
    
    private lazy var requestButton: MWRedButton = {
        let button = MWRedButton()
        button.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        return button
    }()
    
    // MARK: - UI Functions
    
    private func setupUI() {
        self.view.addSubview(requestButton)
       
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.requestButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(buttonSize)
        }
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    // MARK: - Private Functions
    
    private func discoverMovie(year: String? = "", voteMin: String? = "", voteMax: String? = "", counries: [String]) {
        MWNet.sh.request(urlPath: Endpoints.getMovieDiscover.path,
                         parameters: ["year" : year ?? "",
                                      "region" : counries.joined(separator: "%2C%20"),
                            "vote_average.gte" : voteMin ?? "",
                            "vote_average.lte" : voteMax ?? ""],
                         successHandler: { [weak self] (_ response: MWApiResults) in
                            self?.delegate?.buttonPressed(response.results)
                            
                            MWI.sh.popVC()
        }) { [weak self] (error) in
            DispatchQueue.main.async {
                self?.alert(message: error.description)
            }
        }
    }
    
    @objc private func popVC() {
        MWI.sh.popVC()
    }
    // MARK: - Functions
    @objc func sendRequest() {
        self.discoverMovie(year: "2019", counries: countries)
    }
}
