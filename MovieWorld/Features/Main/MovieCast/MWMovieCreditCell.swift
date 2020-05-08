//
//  MWMovieCreditCell.swift
//  MovieWorld
//
//  Created by Admin on 10/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit
import Foundation

protocol CreditViewLayout {
    func layout(on view: UIView)
    init()
}

final class MWMovieCreditCell: CreditViewLayout {
    
    private let ImageSize = CGSize(width: 70, height: 70)
    private let edgeInsets = UIEdgeInsets(top: 10, left: 135, bottom: 10, right: 20)
    var creditId: Int? {
        didSet {
            fetchCreditDetail()
        }
    }
    var credit: CreditDetail? {
        didSet {
            set()
        }
    }
    
    private lazy var creditStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        
        stackView.addArrangedSubview(self.surnameLabel)
        stackView.addArrangedSubview(self.nameLabel)
        stackView.addArrangedSubview(self.birthLabel)

        return stackView
    }()
    
    private lazy var creditImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var surnameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
           let label = UILabel()
           label.numberOfLines = 0
           label.font = .boldSystemFont(ofSize: 13)
           return label
       }()
    
    private lazy var birthLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = UIColor(hexString: "#b9b9b9")
        return label
    }()
    
    private lazy var seperator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(named: "GreyColor")?.withAlphaComponent(0.05)
        return line
    }()
    
    // MARK: - Private functions

    private func makeConstraints() {
        
        self.creditStackView.snp.makeConstraints { (make) in
            make.left.equalTo(creditImageView.snp.right).offset(16)
            make.right.equalToSuperview()
            make.bottom.top.equalToSuperview().inset(edgeInsets)
        }
        
        self.creditImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(ImageSize)
            make.left.equalToSuperview().offset(25)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        self.seperator.snp.makeConstraints { (make) in
            make.height.equalTo(4)
            make.left.right.bottom.equalToSuperview()
        }

    }
    
    private func fetchCreditDetail() {
        guard let creditId = creditId else { return }
    
        MWNet.sh.request(urlPath: Endpoints.getPersonDetail(id: creditId).path,
                         successHandler: { [weak self] (_ response: CreditDetail) in
                            self?.credit = response
                            self?.set()
            }) { [weak self] (error) in
                print(error.description)
        }
    }
    
    // MARK: - Functions
    
    func set() {
        guard let credit = credit else { return }

        if let profilePath = credit.profile_path,
            let imageURL = URL(string: Endpoints.getImage(size: 92, profilePath: profilePath).path) {
            
            self.creditImageView.load(url: imageURL)
        } else {
            self.creditImageView.image = UIImage(named: "movieImage")
        }
        self.surnameLabel.text = credit.name
        self.nameLabel.text = credit.name
        self.birthLabel.text = credit.birthday
    }
    
    init() {}
    
    func layout(on view: UIView) {
        self.creditImageView.translatesAutoresizingMaskIntoConstraints = false
        self.creditStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(creditImageView)
        view.addSubview(creditStackView)
        view.addSubview(seperator)
        
        makeConstraints()
    }
}

class CreditView<Layout: CreditViewLayout> : UIView {
    
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

class CreditTableViewCell<Layout: CreditViewLayout> : UITableViewCell {
    
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
