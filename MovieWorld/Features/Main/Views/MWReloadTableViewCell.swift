//
//  MWReloadTableViewCell.swift
//  MovieWorld
//
//  Created by Admin on 10/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class MWReloadTableViewCell: UITableViewCell {
    
    lazy var button: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(named: "RedColor")
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "reloadCell")
        self.contentView.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
