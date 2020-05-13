//
//  MWSearchViewWithArrow.swift
//  MovieWorld
//
//  Created by Admin on 13/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class MWSearchViewWithAroow: UIView {
    
    // MARK: - Gui Variables
    
    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment  = .left
        return label
    }()
    
    lazy var secondLabel: UITextField = {
        let label = UITextField()
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(named: "GreyColor")
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: - Functions
    
    private func setup() {
        self.addSubview(firstLabel)
        self.addSubview(secondLabel)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.firstLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(self.secondLabel.snp.left).inset(150)
        }
        
        self.secondLabel.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.right.equalTo(self.firstLabel.snp.right).offset(150)
        }
    }
}
