//
//  ViewController.swift
//  MovieWorld
//
//  Created by Admin on 15/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class MWViewController: UIViewController {

    private let edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    private let buttonSize = CGSize(width: 200, height: 150)
    private let customView = MWMovieView(frame: CGRect(x: 0, y: 250, width: 414, height: 200))
    private var topButtonConstraint: Constraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(customView)
        self.view.backgroundColor = UIColor(hexString: "#fafafa")
    }
}

