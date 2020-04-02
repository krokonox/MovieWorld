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
    
    // MARK: - Variables

    private let group = DispatchGroup()
    var item: MWGenericCollectionViewCellModel? {
        didSet {
            guard let item = item else { return }
            self.configure(item: item)
            self.setupView()
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
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatal error ")
    }
    
    // MARK: - Private functions

    private func setupView() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(genreAndYear)
        setUpConstrants()
    }
    
    private func setUpConstrants() {
        let imageSize = self.item?.imageSize ?? 185
        self.imageView.snp.makeConstraints { (make) in
            make.height.equalTo(imageSize)
            make.left.right.equalToSuperview().offset(10)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(15)
            make.top.equalTo(imageView).offset(imageSize)
        }
        
        self.genreAndYear.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
    
    // MARK: - Functions

    func configure(item: MWGenericCollectionViewCellModel) {
        if let posterPath = item.image,
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w\(item.imageSize)" + posterPath) {
            self.imageView.load(url: imageURL)
        } else {
            self.imageView.image = UIImage(named: "movieImage")
        }
        self.titleLabel.text = item.firstTitle
        self.genreAndYear.text = item.secondTitle
    }
}
