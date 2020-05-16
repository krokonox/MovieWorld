//
//  MWMovieCreditView.swift
//  MovieWorld
//
//  Created by Admin on 16/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

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
