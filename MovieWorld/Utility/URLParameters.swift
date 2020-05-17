//
//  URLParameters.swift
//  MovieWorld
//
//  Created by Admin on 06/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

func getUrlWith(url: String, path: String, params: [String: String]? = nil) -> URL? {
        guard var components = URLComponents(string: url + path) else { return nil }
        if let params = params {
            components.queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
        }

        return components.url
}
