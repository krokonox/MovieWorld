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

    private var topButtonConstraint: Constraint?

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: UIControl.State())
        button.backgroundColor = .red

        return button
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.text = "I am label"

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .green

        self.view.addSubview(self.saveButton)
        self.view.addSubview(self.textLabel)

        self.makeConstraints()
    }

    private func makeConstraints() {

        self.saveButton.snp.makeConstraints { (make) in
            self.topButtonConstraint = make.top.equalToSuperview().inset(self.edgeInsets).constraint
            make.left.right.equalToSuperview().inset(self.edgeInsets)
            make.height.equalTo(self.buttonSize)
        }

        self.textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.saveButton.snp.bottom).offset(self.edgeInsets.top)
            make.left.right.equalToSuperview().inset(self.edgeInsets)
        }
    }
}
