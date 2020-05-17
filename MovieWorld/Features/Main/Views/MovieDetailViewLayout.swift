//
//  MovieDetailViewLayout.swift
//  MovieWorld
//
//  Created by Admin on 05/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

final class MovieDetailViewLayout: ViewLayout {
    
    // MARK: - Variables
    
    private let imageSize = CGSize(width: 70, height: 100)
    private let edgeInsets = UIEdgeInsets(top: 10, left: 135, bottom: 10, right: 20)
    private let imageBaseUrl = "https://image.tmdb.org/t/p/w185"
    var movie: MWMovie?
    
    // MARK: - Gui Variables
    
    private lazy var movieStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5

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
        label.numberOfLines = 0
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
        label.numberOfLines = 0
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
    
    // MARK: - Initialization

    init() {}
    
    // MARK: - Private functions

    private func makeConstraints() {
        
        self.movieStackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(edgeInsets)
            make.left.equalTo(movieImageView).offset(135)
            make.right.equalToSuperview()
        }

        self.movieRatingView.snp.makeConstraints { (make) in
            make.top.equalTo(movieGenreView.snp.bottom).offset(40)
            make.bottom.equalToSuperview()
        }
        
        self.movieGenreView.snp.makeConstraints { (make) in
            make.bottom.equalTo(movieRatingView).inset(40)
        }
        
        self.movieImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(imageSize)
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().offset(25)
        }
        
        self.seperator.snp.makeConstraints { (make) in
            make.height.equalTo(4)
            make.left.right.bottom.equalToSuperview()
        }

    }
    // MARK: - Functions
    
    func set(movie: MWMovie) {
        if let posterPath = movie.posterPath,
           let imageURL = URL(string: imageBaseUrl + posterPath) {
            
            self.movieImageView.load(url: imageURL)
        } else {
            self.movieImageView.image = UIImage(named: "movieImage")
        }
        self.titleLabel.text = movie.title
        self.movieGenreView.text = "\(movie.genres.map { $0 }.joined(separator: ", ")) "
        self.movieYearView.text = "\(movie.releaseDate)"
        self.movieRatingView.text = "\(movie.voteAverage) IMDB"
    }
    
    func layout(on view: UIView) {
        self.movieImageView.translatesAutoresizingMaskIntoConstraints = false
        self.movieStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self.movieImageView)
        view.addSubview(self.movieStackView)
        view.addSubview(self.seperator)
        
        self.setupViews()
        self.makeConstraints()
    }
    
    func setupViews() {
        self.movieStackView.addArrangedSubview(self.titleLabel)
        self.movieStackView.addArrangedSubview(self.movieYearView)
        self.movieStackView.addArrangedSubview(self.movieGenreView)
        self.movieStackView.addArrangedSubview(self.movieRatingView)
    }
}
