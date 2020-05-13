//
//  MWSearchWithSlider.swift
//  MovieWorld
//
//  Created by Admin on 13/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

protocol MWSearchWithSliderDelegate: class {
    func sliderValueDidChange()
}

class MWSearchWithSlider: UIView {
    
    var valueFrom: Int = 1
    var valueTo: Int = 10
    weak var delegate: MWSearchWithSliderDelegate?
    
    // MARK: - Gui Variables
    
    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment  = .left
        label.text = "Rating"
        return label
    }()
    
    lazy var secondLabel: UITextField = {
        let label = UITextField()
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(named: "GreyColor")
        label.textAlignment = .right
        return label
    }()
    
    lazy var slider: UISlider = {
        let sldr = UISlider()
        sldr.minimumValue = 1
        sldr.maximumValue = 10
        sldr.tintColor = UIColor.init(named: "RedColor")?.withAlphaComponent(0.6)
        sldr.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        sldr.semanticContentAttribute = .forceLeftToRight
        return sldr
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
        self.addSubview(slider)
        self.addSubview(firstLabel)
        self.addSubview(secondLabel)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.firstLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.right.equalTo(self.secondLabel.snp.left).inset(150)
        }
        
        self.secondLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalTo(self.firstLabel.snp.right).offset(150)
            make.bottom.equalTo(slider.snp.top)
        }
        
        self.slider.snp.makeConstraints { (make) in
            //make.top.equalTo(self.secondLabel.snp.bottom).offset(45)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc private func sliderValueDidChange() {
        self.valueFrom = Int(slider.value)
        self.secondLabel.text = "From \(self.valueFrom)"
    }
}
