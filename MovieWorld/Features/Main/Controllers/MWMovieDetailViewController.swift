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
    var movieId: Int?
    var movie: MWMovie? {
        didSet {
            self.updateMovieDetail()
        }
    }
    
    lazy var cell: View<MovieDetailViewLayout> = {
        var movieCell = View<MovieDetailViewLayout>(frame: .zero)
        return movieCell
    }()
    
    lazy var videoView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
   
    
    // MARK: - Private Functions
    
    private func fetchMovieDetail() {
        guard let movieId = movie?.id else {
            return
        }
        print("klsndfksdklfn", movieId)
        activityIndicator.startAnimating()
      
        MWNet.sh.request(urlPath: "movie/" + String(movieId),
                         parameters: ["append_to_response" : "videos"],
                         successHandler: { [weak self] (_ response: MWMovie) in
                            
            self?.activityIndicator.stopAnimating()
            self?.movie = response
            print(response)
        }) { [weak self] (error) in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func updateMovieDetail() {}
    
//    private func playVideo() {
//        guard let movie = movie else { return }
//        guard let video = movie.videos?.results.first else { return }
//
//        let playerVC = AVPlayerViewController()
//
//        XCDYouTubeClient.default().getVideoWithIdentifier(video.key) {[weak self, weak playerVC] (video, error) in
//            if let _ = error {
//                self?.dismiss(animated: true, completion: nil)
//                return
//            }
//            guard let video = video else {
//                self?.dismiss(animated: true, completion: nil)
//
//                return
//            }
//
//            let streamURL: URL
//            if let url = video.streamURLs[XCDYouTubeVideoQuality.HD720.rawValue]  {
//                streamURL = url
//            } else if let url = video.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] {
//                streamURL = url
//            } else if let url = video.streamURLs[XCDYouTubeVideoQuality.small240.rawValue] {
//                streamURL = url
//            } else if let urlDict = video.streamURLs.first {
//                streamURL = urlDict.value
//            } else {
//                self?.dismiss(animated: true, completion: nil)
//
//                return
//            }
//
//            playerVC?.player = AVPlayer(url: streamURL)
//            playerVC?.view.frame = (self?.videoView.frame)!
//            self?.addChild(playerVC!)
//            self?.view.addSubview(playerVC!.view)
//            playerVC?.player?.play()
//        }
//    }
    
    
    
    private func setupViews() {
        self.cell.layout.set(movie: movie!)
        
        self.view.addSubview(cell)
        self.view.addSubview(videoView)
    }
    
    private func setConstraints() {
        self.cell.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(140)
            make.height.equalTo(142)
        }
        
        self.videoView.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview().offset(16)
            make.top.equalTo(cell.snp.bottom).offset(20)
            make.height.equalTo(166)
        }
    }
    
    
    // MARK: - Functions
    
    func set(movie: MWMovie) {
        self.movie = movie
        self.cell.layout.set(movie: movie)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.setupViews()
        self.setConstraints()
        self.fetchMovieDetail()
//        self.playVideo()
    }
    
    init(movie: MWMovie) {
        self.movie = movie
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CollectionView Extension
    
    
    
}
