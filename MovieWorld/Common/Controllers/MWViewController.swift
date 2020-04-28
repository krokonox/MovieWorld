//
//  MWViewController.swift
//  MovieWorld
//
//  Created by Admin on 20/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWViewController: UIViewController {
    
    var name: String
    var backgroundColor: UIColor
    var nextVC: UIViewController

    init(_ name: String, _ backgroundColor: UIColor, _ nextVC: UIViewController) {    
        self.name = name
        self.backgroundColor = backgroundColor
        self.nextVC = nextVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        self.title = name
    }
}
