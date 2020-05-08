//
//  MWMovieDetailViewController.swift
//  MovieWorld
//
//  Created by Admin on 26/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

//  In the process

import UIKit
import SnapKit
import XCDYouTubeKit
import AVKit

class MWMovieDetailViewController: UIViewController {
    
    // MARK: - Variables
    
    private let dispatch = DispatchGroup()
    private let urlPath = "movie/"
    
    private var edgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    private var sectionInset = UIEdgeInsets(top: 30, left: 15, bottom: 10, right: 15)
    private var itemSize = CGSize(width: 90, height: 150)
    private var activityIndicator = UIActivityIndicatorView()
    private var avPlayer: AVPlayer?
    
    var movieModel: MWMovie?
    var movie: MWMovieDetailResult? {
        didSet {
            self.setupViews()
            self.collectionView.collectionView.reloadData()
        }
    }
    
    // MARK: - Lazy variables
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshCntrl = UIRefreshControl()
        refreshCntrl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshCntrl.addTarget(self, action: #selector(self.refresh),
                               for: UIControl.Event.valueChanged)
        return refreshCntrl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: UIScreen.main.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var collectionView: MWCollectionView = {
        let collection = MWCollectionView(frame: .zero, itemSize: self.itemSize)
        collection.collectionView.delegate = self
        collection.collectionView.dataSource = self
        collection.pushVCButtonAction = { [weak self] in
            self?.pushVC()
        }
        return collection
    }()
    
    private lazy var movieCellView: View<MovieDetailViewLayout> = View<MovieDetailViewLayout>(frame: .zero)

    private lazy var videoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(named: "GreyColor")?.withAlphaComponent(0.15)
        return view
    }()
    
    private lazy var descriptionView: UIView = UIView()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Description"
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private lazy var descriptionText: UILabel = {
        let description = UILabel()
        description.numberOfLines = 0
        return description
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.setImage(UIImage(named: "PlayButton"), for: .normal)
        button.addTarget(self, action: #selector(playVideoButtonTapped), for: .allTouchEvents)
        return button
    }()
    
    // MARK: - Initialization
    
    init(movie: MWMovie) {
        self.movieModel = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Functions
    
    private func setupViews() {
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(refreshControl)
        self.scrollView.addSubview(contentView)
        
        self.contentView.addSubview(movieCellView)
        self.contentView.addSubview(videoView)
        self.contentView.addSubview(descriptionView)
        self.contentView.addSubview(collectionView)
        
        self.descriptionText.text = self.movie?.overview
        self.descriptionView.addSubview(descriptionTitleLabel)
        self.descriptionView.addSubview(descriptionText)
        
        self.videoView.addSubview(playButton)
        
        self.setConstraints()
        
        if let movieCellView = movieModel {
            self.movieCellView.layout.set(movie: movieCellView)
        }
        
        self.collectionView.hideButton()
    }
    
    private func setConstraints() {
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.height.width.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        
        self.movieCellView.snp.makeConstraints { (make) in
            make.height.equalTo(142)
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        self.videoView.snp.makeConstraints { (make) in
            make.height.equalTo(166)
            make.top.equalTo(movieCellView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        self.playButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.descriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(videoView.snp.bottom).offset(60)
            make.left.right.equalToSuperview().offset(16)
        }
        
        self.descriptionTitleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        self.descriptionText.snp.makeConstraints { (make) in
            make.top.equalTo(self.descriptionTitleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }
        
        self.collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(self.itemSize.height)
            make.top.equalTo(self.descriptionText.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.fetchMovieDetail()
    }
    
    // MARK: - Private Functions
    
    private func fetchMovieDetail() {
        guard let movieId = movieModel?.id else {
            return
        }
        self.activityIndicator.startAnimating()
        self.dispatch.enter()
        MWNet.sh.request(urlPath: self.urlPath + String(movieId),
                         parameters: ["append_to_response" : "videos,credits"],
                         successHandler: { [weak self] (_ response: MWMovieDetailResult) in  
                            guard let self = self else { return }
                            self.movie = response
                            self.setupViews()
                            self.dispatch.leave()
        }) { [weak self] (error) in
            self?.showError(error.description)
            self?.dispatch.leave()
        }
        
        self.dispatch.notify(queue: .main) { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.activityIndicator.stopAnimating()
        }
    }

    private func playVideo() {
        guard let movie = movie, let video = movie.videos?.results.first else { return }
        
        XCDYouTubeClient.default().getVideoWithIdentifier(video.key) {
            [weak self] (video, error) in
            guard let video = video, error == nil else { return }
            
            let streamURL: URL
            if let url = video.streamURLs[XCDYouTubeVideoQuality.HD720.rawValue] {
                streamURL = url
            } else if let url = video.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] {
                streamURL = url
            } else if let url = video.streamURLs[XCDYouTubeVideoQuality.small240.rawValue] {
                streamURL = url
            } else if let urlDict = video.streamURLs.first {
                streamURL = urlDict.value
            } else {
                return
            }
            
            let playerVC = AVPlayerViewController()
            
            playerVC.player = AVPlayer(url: streamURL)
            playerVC.player?.play()
            
            self?.present(playerVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Functions
    
    @objc func playVideoButtonTapped() {
        self.playVideo()
    }
    
    @objc func refresh() {
        self.fetchMovieDetail()
    }
    
    @objc func pushVC() {
        let vc = MWMovieCreditListViewController()
        vc.set(credits: (self.movie?.credits?.cast) ?? [])
        MWI.sh.push(vc: vc)
    }
    
    private func showError(_ error: String) {
        self.alert(message: error.description, title: "")
    }
}

// MARK: - CollectionView Extension

extension MWMovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCellWith(row: [MWMovieCell]) {
        self.collectionView.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movie?.credits?.cast.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCast = self.movie?.credits?.cast[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWMovieCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? MWMovieCell, let cast = movieCast {
            let cast = MWGenericCollectionViewCellModel(cast: cast)
            cell.item = cast
            return cell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets
    }
}
