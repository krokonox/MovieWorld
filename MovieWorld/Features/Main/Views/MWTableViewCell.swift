//
//  MWTableViewCell.swift
//  MovieWorld
//
//  Created by Admin on 26/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//
import Foundation
import SnapKit
import UIKit

class MWTableViewCell: UITableViewCell {
    
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var movies: [MWMovie] = []
    var edgeInsects = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    var title: String = ""
    var button: UIButton = UIButton()
    
    lazy var Title: UILabel = {
        let Title = UILabel()
        Title.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        Title.textAlignment = .left
        return Title
    }()
    
    lazy var Button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .white
        button.setTitle(" All -> ", for: .normal)
        button.backgroundColor = UIColor(named: "RedColor")
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell")
        configureCollectionView()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionView() {
       collectionView.dataSource = self
       collectionView.delegate = self
       collectionView.reloadData()
      
       layout.sectionInset = UIEdgeInsets(top: 30, left: 15, bottom: 10, right: 15)
       layout.scrollDirection = .horizontal
       layout.itemSize = CGSize(width: 130, height: 180)
       layout.minimumLineSpacing = 8.0
       layout.minimumInteritemSpacing = 10.0
       
       self.collectionView.collectionViewLayout = layout
       self.collectionView.backgroundColor = .white
       self.contentView.addSubview(collectionView)
        
       self.collectionView.register(MWMovieCell.self, forCellWithReuseIdentifier: "cell")
        
       self.collectionView.snp.makeConstraints { (make) in
           make.edges.equalToSuperview()
       }
    }
    
    private func setupViews() {
        self.contentView.addSubview(Title)
        self.contentView.addSubview(Button)
        
        self.Title.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(collectionView).offset(12)
        }
        self.Button.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(62)
            make.height.equalTo(25)
            make.top.equalTo(collectionView).offset(12)
        }
    }
    
    private func setupConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func set(movies: [MWMovie], title: String) {
        self.movies = movies
        self.Title.text = title
    }
}

extension MWTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCellWith(row: [MWMovieCell]) {
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MWMovieCell {
            cell.movie = movies[indexPath.row]
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsects
    }
    
}
