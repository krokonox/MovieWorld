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

class MWMovieDetailViewController: UIViewController {
    
    // MARK: - Variables
    
    var movieId: Int?
    var movie: MWMovie? {
        didSet {
            self.updateMovieDetail()
        }
    }
    
    lazy var cell: MWMovieDetailCell = {
        var movieCell = MWMovieDetailCell()
        return movieCell
    }()
    
   
    
    // MARK: - Private Functions
    
    private func fetchMovieDetail() {}
    
    private func updateMovieDetail() {}
    
    private func setupViews() {
        self.view.addSubview(cell)
    }
    
    private func setConstraints() {}
    
    
    // MARK: - Functions
    
    func set(movie: MWMovie) {
        self.movie = movie
        self.cell.set(movie: movie)
    }
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchMovieDetail()
        
    }
    
    
    
    
    
    
    // MARK: - CollectionView Extension
    
    
    
}
