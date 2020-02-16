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
    private let edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setupView()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .red
//        self.addSubview(movieStackView)
        self.addSubview(movieImageView)
        makeConstraintsWithSnapKit()
    }
    
    private lazy var movieStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .green
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 7
//        stackView.addArrangedSubview(movieImageView)
        stackView.addArrangedSubview(movieTitleView)
        
        return stackView
    }()
    
    private lazy var movieImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "trash")
        return image
    }()
    
    private lazy var movieTitleView: UILabel = {
        let label = UILabel()
        label.text = "Green Book"
        label.backgroundColor = .blue
        label.sizeToFit()

        return label
    }()

    private func makeConstraintsWithSnapKit() {
        
        self.movieStackView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.bottom.top.equalToSuperview().offset(20)
            make.left.equalTo(movieImageView).offset(20)
        }
        
        self.movieImageView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.width.equalTo(100)
            make.left.right.equalTo(movieStackView).offset(20)
        }
              
    }
    private func makeConstraintsWithAnchors () {}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    private lazy var movieTitleLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = FontHelper.light(withSize: 12.0)
//        return label
//    }()
//
//    private lazy var voteAverageLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = FontHelper.light(withSize: 12.0)
//        return label
//    }()
//
//    private lazy var voteAverageLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = FontHelper.light(withSize: 12.0)
//        return label
//    }()
//
//    private lazy var voteAverageLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = FontHelper.light(withSize: 12.0)
//        return label
//    }()
//
}
