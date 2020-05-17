//
//  MWGenericMovieDetailView.swift
//  MovieWorld
//
//  Created by Admin on 28/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

protocol ViewLayout {
    func layout(on view: UIView)
    init()
}

class View<Layout: ViewLayout>: UIView {
    
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

class TableViewCell<Layout: ViewLayout>: UITableViewCell {
    
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
