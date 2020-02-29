//
//  NetworkInterface.swift
//  MovieWorld
//
//  Created by Admin on 29/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import  UIKit

typealias MWNet = MWNetwork

class MWNetwork {
    
    static let sh = MWNetwork()
    
    private init() {}
 
    private let baseURL = URLComponents(string: "https://api.themoviedb.org/3/")
    private let api_key = "79d5894567be5b76ab7434fc12879584"
    
    private var URLParameters: [String: String] {
        return ["api_key" : api_key]
    }
    
    var dataTask: URLSessionDataTask?
    
    lazy var session = URLSession(configuration: .default)
    
    private func request<T: Decodable>(urlPath: String, queryParameters: [String: String], successHandler: @escaping(T) -> ()) {
        
        let fullPath = getUrlWithParams(fullPath: urlPath, params: queryParameters)
        
        
        dataTask = session.dataTask(with: <#T##URL#>)
    }
}
