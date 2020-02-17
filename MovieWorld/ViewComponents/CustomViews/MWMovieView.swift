//
//  MWMovieView.swift
//  MovieWorld
//
//  Created by Admin on 16/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MWMovieView: UIView {
    
    private let ImageSize = CGSize(width: 100, height: 120)
    private let edgeInsets = UIEdgeInsets(top: 20, left: 135, bottom: 20, right: 20)

    // MARK: - Configurable properties
    
    private lazy var movieStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 5
        
        stackView.addArrangedSubview(movieTitleView)
        stackView.addArrangedSubview(movieYearView)
        stackView.addArrangedSubview(movieGenreView)
        stackView.addArrangedSubview(movieRatingView)

        return stackView
    }()
    
    private lazy var movieImageView: UIImageView = {
        let image = UIImageView()
        
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        image.image = UIImage(named: "")
        image.image = #imageLiteral(resourceName: "Image")
        return image
    }()
    
    private lazy var movieTitleView: UILabel = {
        let label = UILabel()
        label.text = "Green Book"
        label.font = .boldSystemFont(ofSize: 21)
        
        return label
    }()
    
    private lazy var movieYearView: UILabel = {
        let label = UILabel()
        label.text = "2018, USA"
        
        return label
    }()
    
    private lazy var movieGenreView: UILabel = {
        let label = UILabel()
        label.text = "Comedy, Drama, Foreign"
        label.textColor = UIColor(hexString: "#b9b9b9")
        
        return label
    }()
    
    private lazy var movieRatingView: UILabel = {
        let label = UILabel()
        label.text = "IMDB 8.2, KP 8.3"
       
        return label
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setupView()
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        self.backgroundColor = .white
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(movieImageView)
        self.addSubview(movieStackView)
        
        makeConstraintsWithSnapKit()
    }
    
    private func makeConstraintsWithSnapKit() {
        
        self.movieStackView.snp.makeConstraints { (make) in
            make.left.equalTo(movieImageView).offset(135)
            make.bottom.top.equalToSuperview().inset(edgeInsets)
        }

        self.movieRatingView.snp.makeConstraints { (make) in
            make.bottom.equalTo(movieGenreView).offset(70)
        }
        
        self.movieImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(ImageSize)
            make.left.equalToSuperview().offset(25)
            make.top.bottom.equalToSuperview().inset(15)
        }
              
    }
    
    private func makeConstraintsWithAnchors () {
        
        NSLayoutConstraint.activate([
             movieImageView.topAnchor.constraint(equalTo: self.movieImageView.topAnchor, constant: 15),
             movieImageView.bottomAnchor.constraint(equalTo: self.movieImageView.bottomAnchor, constant: 15),
             movieImageView.leftAnchor.constraint(equalTo: self.movieImageView.leftAnchor, constant: 25),
             movieImageView.heightAnchor.constraint(equalToConstant: 120),
             movieImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            movieStackView.topAnchor.constraint(equalTo: self.movieStackView.topAnchor, constant: 20),
            movieStackView.bottomAnchor.constraint(equalTo: self.movieStackView.bottomAnchor, constant: 20),
            movieStackView.leftAnchor.constraint(equalTo: movieImageView.leftAnchor, constant: 135)
        ])
        
        NSLayoutConstraint.activate([
            movieRatingView.bottomAnchor.constraint(equalTo: self.movieGenreView.bottomAnchor, constant: 70)
        ])
    }
}
