//
//  MWMovieCell.swift
//  MovieWorld
//
//  Created by Admin on 25/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//
import Foundation
import UIKit
import SnapKit

class MWMovieCell: UICollectionViewCell {
    
    let group = DispatchGroup()
    var movie: MWMovie? {
        didSet {
            guard let movie = movie else { return }
            self.set(movie: movie)
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let Title = UILabel()
        Title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        Title.textAlignment = .left
        return Title
    }()
    
    private lazy var genreAndYear: UILabel = {
        let genreAndYear = UILabel()
        genreAndYear.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        genreAndYear.textAlignment = .left
        return genreAndYear
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatal error ")
    }
    
    private func setupView() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(genreAndYear)
        setUpConstrants()
    }
    
    func set(movie: MWMovie) {
        if let posterPath = movie.poster_path,
           let imageURL = URL(string: "https://image.tmdb.org/t/p/w185" + posterPath) {
            
            self.imageView.load(url: imageURL)
        } else {
            self.imageView.image = UIImage(named: "movieImage")
        }
        self.titleLabel.text = movie.title
        self.genreAndYear.text = " \(movie.genres.map { $0 }.joined(separator: ", ")), \(movie.release_date) "
    }

    private func setUpConstrants() {
        self.imageView.snp.makeConstraints { (make) in
            make.height.equalTo(180)
            make.left.right.equalToSuperview().offset(10)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(15)
            make.top.equalTo(imageView).offset(190)
        }
        
        self.genreAndYear.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(50)
        }
    }
}
