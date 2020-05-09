//
//  MWMovieCreditDetail.swift
//  MovieWorld
//
//  Created by Admin on 10/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class MWMovieCreditDetailViewController: MWViewController {
 
    // MARK: - Variables
    
    var cast: CreditDetail?
    var castId: Int {
        didSet {
            self.fetchCreditDetail()
        }
    }
    
    // MARK: - Gui variables
    
    private lazy var creditView: CreditView<MWMovieCreditCell> = CreditView<MWMovieCreditCell>(frame: .zero)
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: UIScreen.main.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        return title
    }()
    private lazy var biography: UILabel = {
        let bioText = UILabel()
        bioText.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        bioText.numberOfLines = 0
        return bioText
    }()
    
    // MARK: - Initialization
    
    init(castId: Int) {
        self.castId = castId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Functions
    
    private func setupViews() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        self.contentView.addSubview(creditView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(biography)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.height.width.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        
        self.creditView.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.top.left.right.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(creditView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.bottom.equalTo(biography.snp.top)
        }
        
        self.biography.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.fetchCreditDetail()
    }
    
    // MARK: - Private Functions
    
    private func fetchCreditDetail() {
        MWNet.sh.request(urlPath: Endpoints.getPersonDetail(id: castId).path,
                         successHandler: { [weak self] (_ response: CreditDetail) in
                            self?.cast = response
                            self?.configure()
        }) { [weak self] (error) in
            self?.alert(message: error.description)
        }
    }
    
    private func configure() {
        self.creditView.layout.creditId = self.castId
        self.titleLabel.text = self.cast?.known_for_department
        self.biography.text = self.cast?.biography
    }
}
