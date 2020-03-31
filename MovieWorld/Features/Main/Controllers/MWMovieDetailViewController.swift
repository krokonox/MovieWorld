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
    
    var movieId: Int? {
        return movieCell?.id
    }
    var movieCell: MWMovie? {
        didSet {
            self.updateMovieDetail()
        }
    }
    var movie: MWMovieDetailResult? {
        didSet {}
    }
    
    // MARK: - Lazy variables
    
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
    
    lazy var descriptionView: UIView = {
        let view = UIView()
        view.addSubview(self.descriptionTitleLabel)
        view.addSubview(self.descriptionText)
        return view
    }()
    
    lazy var descriptionTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Description"
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    lazy var descriptionText: UILabel = {
        let description = UILabel()
        description.numberOfLines = 0
        return description
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.setImage(UIImage(named: "PlayButton"), for: .normal)
        button.addTarget(self, action: #selector(playVideoButtonTapped), for: .allTouchEvents)
        return button
    }()
    
    // MARK: - Private Functions
    
    private func fetchMovieDetail() {
        guard let movieId = movieCell?.id else {
            return
        }
        
        activityIndicator.startAnimating()
        self.dispatch.enter()
        MWNet.sh.request(urlPath: "movie/" + String(movieId),
                         parameters: ["append_to_response" : "videos"],
                         successHandler: { [weak self] (_ response: MWMovieDetailResult) in
                            
                            self?.activityIndicator.stopAnimating()
                            self?.movie = response
                            self?.setupViews()
                            self?.dispatch.leave()
                            
        }) { [weak self] (error) in
            self?.activityIndicator.stopAnimating()
        }
        
        self.dispatch.notify(queue: .main) { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
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

    private func setupViews() {
        self.cell.layout.set(movie: movieCell!)
        
        self.view.addSubview(cell)
        self.view.addSubview(videoView)
        self.view.addSubview(descriptionView)
        self.descriptionText.text = self.movie?.overview
    }
    
    private func setConstraints() {
        self.cell.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(140)
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
            make.height.equalTo(300)
        }
        
        self.descriptionTitleLabel.snp.makeConstraints{ (make) in
            make.left.top.right.equalToSuperview()
        }
        
        self.descriptionText.snp.makeConstraints{ (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.descriptionTitleLabel).offset(8)
        }
    }
    
    
    // MARK: - Functions
    
    func set(movie: MWMovie) {
        self.movieCell = movie
        self.cell.layout.set(movie: movieCell!)
    }
    
    @objc func playVideoButtonTapped() {
        self.playVideo()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.setupViews()
        self.setConstraints()
        self.fetchMovieDetail()
        self.playVideo()
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
