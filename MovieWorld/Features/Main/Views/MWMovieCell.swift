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
    
    var movie: MWMovie? {
        didSet {
            guard let movie = movie else { return }
            set(movie: movie)
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var Title: UILabel = {
        let Title = UILabel()
        Title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        Title.textAlignment = .left
        return Title
    }()
    
    lazy var genreAndYear: UILabel = {
        let genreAndYear = UILabel()
        genreAndYear.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        genreAndYear.textAlignment = .left
        return genreAndYear
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatal error ")
    }
    
    private func setupView() {
        self.addSubview(imageView)
        self.addSubview(Title)
        self.addSubview(genreAndYear)
        setUpConstrants()
    }
    
    func set(movie: MWMovie) {
        self.imageView.image = UIImage(named: movie.poster_path)
            self.Title.text = movie.title
        self.genreAndYear.text = "\(movie.genre_ids), \(movie.release_date)"
    }
    
    private func setUpConstrants() {
        self.imageView.snp.makeConstraints { (make) in
            make.height.equalTo(180)
            make.left.right.equalToSuperview().offset(10)
        }
        
        self.Title.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(15)
            make.top.equalTo(imageView).offset(190)
//            make.bottom.equalTo(genreAndYear).offset(30)
        }
        
        self.genreAndYear.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(15)
            make.bottom.equalTo(Title).offset(15)
        }
    }
}
