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

class MWMovieCell: UIView {
    
    var image: UIImage = #imageLiteral(resourceName: "main")
    var movieTitle: String = ""
    var movieYear: String = ""
    var movieGenre: String = ""
        
    
    lazy var imageView: UIImageView = {
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 185))
      imageView.image = image
      return imageView
    }()
    
    lazy var Title: UILabel = {
      let Title = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
      Title.font = UIFont.systemFont(ofSize: 22, weight: .medium)
      Title.text = movieTitle
      Title.textAlignment = .center
      return Title
    }()
    
    lazy var genreAndYear: UILabel = {
      let genreAndYear = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
      genreAndYear.font = UIFont.systemFont(ofSize: 22, weight: .medium)
      genreAndYear.text = "\(movieYear), \(movieGenre))"
      genreAndYear.textAlignment = .center
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
    }
    
    private func setUpConstrants() {
        self.imageView.snp.makeConstraints { (make) in
            make.height.equalTo(185)
            make.width.equalTo(130)
            make.bottom.equalTo(Title)
        }
        
        self.Title.snp.makeConstraints { (make) in
            make.height.equalTo(305)
            make.left.right.equalToSuperview()
        }
        
        self.genreAndYear.snp.makeConstraints { (make) in
            make.height.equalTo(305)
            make.left.right.equalToSuperview()
        }
    }
}
