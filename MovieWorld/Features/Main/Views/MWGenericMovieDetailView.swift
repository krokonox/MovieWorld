//
//  MWGenericMovieDetailView.swift
//  MovieWorld
//
//  Created by Admin on 28/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol ViewLayout {
    func layout(on view: UIView)
    init()
}

final class MovieDetailViewLayout: ViewLayout {
    
    private let ImageSize = CGSize(width: 70, height: 100)
    private let edgeInsets = UIEdgeInsets(top: 10, left: 135, bottom: 10, right: 20)
    var movie: MWMovie? {
        didSet {}
    }
    
    private lazy var movieStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        
        stackView.addArrangedSubview(self.titleLabel)
        stackView.addArrangedSubview(self.movieYearView)
        stackView.addArrangedSubview(self.movieGenreView)
        stackView.addArrangedSubview(self.movieRatingView)

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

    // MARK: - Private functions

    private func makeConstraintsWithSnapKit() {
        
        self.movieStackView.snp.makeConstraints { (make) in
            make.left.equalTo(movieImageView).offset(135)
            make.right.equalToSuperview()
            make.bottom.top.equalToSuperview().inset(edgeInsets)
        }

        self.movieRatingView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.top.equalTo(movieGenreView.snp.bottom).offset(40)
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
           let imageURL = URL(string: Endpoints.getImage(size: 92, profilePath: posterPath).path) {
            
            self.movieImageView.load(url: imageURL)
        } else {
            self.movieImageView.image = UIImage(named: "movieImage")
        }
        self.titleLabel.text = movie.title
        self.movieGenreView.text = "\(movie.genres.map { $0 }.joined(separator: ", ")) "
        self.movieYearView.text = "\(movie.release_date)"
        self.movieRatingView.text = "\(movie.vote_average) IMDB"
    }
    
    init() {}
    
    func layout(on view: UIView) {
        self.movieImageView.translatesAutoresizingMaskIntoConstraints = false
        self.movieStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(movieImageView)
        view.addSubview(movieStackView)
        view.addSubview(seperator)
        
        makeConstraintsWithSnapKit()
    }
}

class View<Layout: ViewLayout> : UIView {
    
    public let layout: Layout
    
    override init(frame: CGRect) {
        self.layout = Layout()
        super.init(frame: frame)
        layout.layout(on: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TableViewCell<Layout: ViewLayout> : UITableViewCell {
    
    public let layout: Layout
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.layout = Layout()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout.layout(on: contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
