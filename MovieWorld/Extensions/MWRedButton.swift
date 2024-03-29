//
//  RedButton.swift
//  MovieWorld
//
//  Created by Admin on 05/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWRedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(named: "RedColor")
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.textColor = .white
    }
}
