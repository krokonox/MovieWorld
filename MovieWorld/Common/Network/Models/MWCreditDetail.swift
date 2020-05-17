//
//  MWCreditDetail.swift
//  MovieWorld
//
//  Created by Admin on 10/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct CreditDetail: Decodable {
    let birthday: String?
    let name: String
    let known_for_department: String
    let biography: String
    let profile_path: String?
}
