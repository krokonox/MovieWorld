//
//  MWCountryTableViewCell.swift
//  MovieWorld
//
//  Created by Admin on 14/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWCountryTableViewCell: UITableViewCell {
    
    // MARK: - Gui Variables
    
    private lazy var checkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "CheckMark")
        return image
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: MWCountryTableViewCell.reuseIdentifier)
        self.setupViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.checkImage.isHidden = !selected
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Functions
    
    private func setupViews() {
        self.contentView.addSubview(checkImage)
        self.checkImage.isHidden = true
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.checkImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
            make.top.right.equalToSuperview()
        }
    }
}
