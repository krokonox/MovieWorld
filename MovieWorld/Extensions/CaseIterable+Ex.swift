//
//  CaseIterable+Ex.swift
//  MovieWorld
//
//  Created by Admin on 05/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

extension CaseIterable where Self: Equatable {

    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}
