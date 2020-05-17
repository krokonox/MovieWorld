//
//  UIPickerViewDS.swift
//  MovieWorld
//
//  Created by Admin on 12/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol UIPickerDelegate: class {
    func didChooseYear(_ year: Int)
}

class UIPickerViewDS: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    weak var delegate: UIPickerDelegate?
    var data: [Int] = Array(1900...2020)
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(data[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let yearSelected = data[row]
        self.delegate?.didChooseYear(yearSelected)
    }
}
