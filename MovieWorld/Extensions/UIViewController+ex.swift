//
//  UIViewController+ex.swift
//  MovieWorld
//
//  Created by Admin on 01/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
