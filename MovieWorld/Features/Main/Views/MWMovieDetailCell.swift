//
//  MWMovieDetailCell.swift
//  MovieWorld
//
//  Created by Admin on 14/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//
import Foundation
import UIKit
import SnapKit

class MWMovieDetailCell: UITableViewCell {
    
    private let ImageSize = CGSize(width: 70, height: 100)
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
        image.image = #imageLiteral(resourceName: "movieImage")
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
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    private lazy var movieGenreView: UILabel = {
        let label = UILabel()
        label.text = "Comedy, Drama, Foreign"
        label.textColor = UIColor(hexString: "#b9b9b9")
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    private lazy var movieRatingView: UILabel = {
        let label = UILabel()
        label.text = "IMDB 8.2, KP 8.3"
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell")
        self.setupView()
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
        
        self.contentView.addSubview(movieImageView)
        self.contentView.addSubview(movieStackView)
        
        makeConstraintsWithSnapKit()
    }
    
    private func makeConstraintsWithSnapKit() {
        
        self.movieStackView.snp.makeConstraints { (make) in
            make.left.equalTo(movieImageView).offset(135)
            make.bottom.top.equalToSuperview().inset(edgeInsets)
        }

        self.movieRatingView.snp.makeConstraints { (make) in
            make.bottom.equalTo(movieGenreView).offset(20)
        }
        
        self.movieImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(ImageSize)
            make.left.equalToSuperview().offset(25)
            make.top.bottom.equalToSuperview().inset(15)
        }
              
    }
}
