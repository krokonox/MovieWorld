//
//  MWMovieDetailViewController.swift
//  MovieWorld
//
//  Created by Admin on 26/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

//  In the process

import Foundation
import UIKit
import SnapKit

class MWMovieDetailViewController: UIViewController {
    
    // MARK: - Variables
    
    var movieId: Int?
    var movie: MWMovie? {
        didSet {
            self.updateMovieDetail()
        }
    }
    
    lazy var cell: View<MovieDetailViewLayout> = {
        var movieCell = View<MovieDetailViewLayout>(frame: .zero)
       
        return movieCell
    }()
    
   
    
    // MARK: - Private Functions
    
    private func fetchMovieDetail() {}
    
    private func updateMovieDetail() {}
    
    private func setupViews() {
        self.view.addSubview(cell)
    }
    
    private func setConstraints() {
        self.cell.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(140)
            make.height.equalTo(142).labeled("heuiuuyjgh")
        }
    }
    
    
    // MARK: - Functions
    
    func set(movie: MWMovie) {
        self.movie = movie
        self.cell.layout.set(movie: movie)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.cell.layout.set(movie: movie!)
        self.view.addSubview(cell)
        setConstraints()
    }
    
    init(movie: MWMovie) {
        self.movie = movie
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CollectionView Extension
    
    
    
}
