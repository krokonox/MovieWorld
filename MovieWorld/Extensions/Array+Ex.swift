//
//  Array+Ex.swift
//  MovieWorld
//
//  Created by Admin on 15/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func removeElement(object: Element) {
        if contains(object) {
            if let index = firstIndex(of: object) {
                remove(at: index)
            }
        }
    }
}
