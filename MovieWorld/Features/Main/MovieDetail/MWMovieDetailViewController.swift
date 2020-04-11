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
    
    private var activityIndicator = UIActivityIndicatorView()
    private let dispatch = DispatchGroup()
    private var avPlayer: AVPlayer!
    private var edgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    private var itemSize = CGSize(width: 90, height: 150)
   
    var movieCell: MWMovie? {
        didSet {
            self.updateMovieDetail()
        }
    }
    var movie: MWMovieDetailResult? {
        didSet {
            self.setupViews()
            self.collectionView.collectionView.reloadData()
        }
    }
    
    // MARK: - Lazy variables
    
    private lazy var refreshControl: UIRefreshControl = { // Is it possible to reuse it from MWMainViewController?
        let refreshCntrl = UIRefreshControl()
        refreshCntrl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshCntrl.addTarget(self, action: #selector(refresh),
                               for: UIControl.Event.valueChanged)
        return refreshCntrl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: UIScreen.main.bounds)
        view.addSubview(self.refreshControl)
        view.addSubview(self.contentView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.addSubview(self.cell)
        view.addSubview(self.videoView)
        view.addSubview(self.descriptionView)
        view.addSubview(self.collectionView)
        return view
    }()

    lazy var cell: View<MovieDetailViewLayout> = {
        var movieCell = View<MovieDetailViewLayout>(frame: .zero)
        return movieCell
    }()
    
    lazy var videoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(named: "GreyColor")?.withAlphaComponent(0.15)
        view.addSubview(self.playButton)
        return view
    }()
    
    private lazy var descriptionView: UIView = {
        let view = UIView()
        view.addSubview(self.descriptionTitleLabel)
        view.addSubview(self.descriptionText)
        return view
    }()
    
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
        button.addTarget(self, action: #selector(playVideoButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var collectionView: MWCollectionView = {
        let collection = MWCollectionView(frame: .zero, itemSize: self.itemSize)
        collection.collectionView.delegate = self
        collection.collectionView.dataSource = self
        collection.reloadButton.addTarget(self, action: #selector(reloadCast), for: .allTouchEvents)
        collection.redButton.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
        return collection
    }()
    
    // MARK: - Private Functions
    //"movie/" + String(movieId)
    private func fetchMovieDetail() {
        guard let movieId = movieCell?.id else {
            return
        }
        activityIndicator.startAnimating()
        self.dispatch.enter()
        MWNet.sh.request(urlPath: Endpoints.getDetail(id: movieId).path,
                         parameters: ["append_to_response" : "videos,credits"],
                         successHandler: { [weak self] (_ response: MWMovieDetailResult) in
                            
                            self?.activityIndicator.stopAnimating()
                            self?.movie = response
                            self?.setupViews()
                            self?.dispatch.leave()
                            
        }) { [weak self] (error) in
            self?.activityIndicator.stopAnimating()
        }
        
        self.dispatch.notify(queue: .main) { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    @objc func reloadCast() {
        self.fetchMovieDetail()
        self.collectionView.collectionView.reloadData()
    }
    
    private func updateMovieDetail() {}

    private func playVideo() {
        guard let movie = movie else { return }

        guard let video = movie.videos?.results.first else { return }

        
        let playerVC = AVPlayerViewController()
        present(playerVC, animated: true, completion: nil)
        XCDYouTubeClient.default().getVideoWithIdentifier(video.key) {[weak self, weak playerVC] (video, error) in
            if let _ = error {
                self?.dismiss(animated: true, completion: nil)
                return
            }
            guard let video = video else {
                self?.dismiss(animated: true, completion: nil)

                return
            }

            let streamURL: URL
            if let url = video.streamURLs[XCDYouTubeVideoQuality.HD720.rawValue]  {
                streamURL = url
            } else if let url = video.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] {
                streamURL = url
            } else if let url = video.streamURLs[XCDYouTubeVideoQuality.small240.rawValue] {
                streamURL = url
            } else if let urlDict = video.streamURLs.first {
                streamURL = urlDict.value
            } else {
                self?.dismiss(animated: true, completion: nil)

                return
            }

            playerVC?.player = AVPlayer(url: streamURL)
            playerVC?.player?.play()
        }
    }
    
    // MARK: - UI Functions
    
    private func setupViews() {
        self.view.addSubview(scrollView)
        self.cell.layout.set(movie: movieCell!)
        self.descriptionText.text = self.movie?.overview
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.scrollView.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints{ (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(self.view)
            make.width.height.equalToSuperview()
        }
        
        self.cell.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(142)
        }
        
        self.videoView.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(cell.snp.bottom).offset(20)
            make.height.equalTo(166)
        }
        
        self.playButton.snp.makeConstraints{ (make) in
            make.center.equalToSuperview()
        }
        
        self.descriptionView.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview().offset(16)
            make.top.equalTo(videoView.snp.bottom).offset(60)
        }
        
        self.descriptionTitleLabel.snp.makeConstraints{ (make) in
            make.left.top.right.equalToSuperview()
        }
        
        self.descriptionText.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.descriptionTitleLabel.snp.bottom).offset(8)
        }
        
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.descriptionText.snp.bottom).offset(20)
            make.height.equalTo(280)
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
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.fetchMovieDetail()
    }
    
    init(movie: MWMovie) {
        self.movieCell = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - CollectionView Extension
    
}
extension MWMovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCellWith(row: [MWMovieCell]) {
        self.collectionView.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movie?.credits?.cast.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MWMovieCell {
            let cast = MWGenericCollectionViewCellModel(cast: (self.movie?.credits?.cast[indexPath.row])!)
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


