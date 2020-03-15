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
    
    // MARK: - Variables
    
    private let ImageSize = CGSize(width: 70, height: 100)
    private let edgeInsets = UIEdgeInsets(top: 10, left: 135, bottom: 10, right: 20)
    var movie: MWMovie? {
        didSet{}
    }
    
    private lazy var movieStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 5
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(movieYearView)
        stackView.addArrangedSubview(movieGenreView)
        stackView.addArrangedSubview(movieRatingView)

        return stackView
    }()
    
    private lazy var movieImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var movieYearView: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(13)
        return label
    }()
    
    private lazy var movieGenreView: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#b9b9b9")
        label.font = label.font.withSize(13)
        return label
    }()
    
    private lazy var movieRatingView: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(13)
        return label
    }()
    
    private lazy var seperator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(named: "GreyColor")?.withAlphaComponent(0.05)
        return line
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
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(movieImageView)
        self.contentView.addSubview(movieStackView)
        self.contentView.addSubview(seperator)
        
        makeConstraintsWithSnapKit()
    }
    
    private func makeConstraintsWithSnapKit() {
        
        self.movieStackView.snp.makeConstraints { (make) in
            make.left.equalTo(movieImageView).offset(135)
            make.bottom.top.equalToSuperview().inset(edgeInsets)
        }

        self.movieRatingView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
        }
        
        self.movieGenreView.snp.makeConstraints { (make) in
            make.bottom.equalTo(movieRatingView).inset(40)
            
        }
        
        self.movieImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(ImageSize)
            make.left.equalToSuperview().offset(25)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        self.seperator.snp.makeConstraints { (make) in
            make.height.equalTo(4)
            make.left.right.bottom.equalToSuperview()
        }
              
    }
    // MARK: - Functions
    
    func set(movie: MWMovie) {
        if let posterPath = movie.poster_path,
           let imageURL = URL(string: "https://image.tmdb.org/t/p/w185" + posterPath) {
            
            self.movieImageView.load(url: imageURL)
        } else {
            self.movieImageView.image = UIImage(named: "movieImage")
        }
        self.titleLabel.text = movie.title
        self.movieGenreView.text = "\(movie.genres.map { $0 }.joined(separator: ", ")) "
        self.movieYearView.text = "\(movie.release_date)"
        self.movieRatingView.text = "\(movie.vote_average) IMDB"
    }
}
