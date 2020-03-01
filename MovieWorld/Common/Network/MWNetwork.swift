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
 
    private let baseURL = "https://api.themoviedb.org/3/"
    private let api_key = "79d5894567be5b76ab7434fc12879584"
    
    var URLParameters: [String: String] {
        return ["api_key" : api_key]
    }
   
    var dataTask: URLSessionDataTask?
    
    lazy var session = URLSession(configuration: .default)
    
    func request<T: Decodable>(urlPath: String, queryParameters: [String: String], successHandler: @escaping(T) -> ()) {
        
        let url = baseURL + urlPath
        let fullPath = getUrlWithParams(fullPath: url, params: queryParameters)
        let request = URLRequest(url: URL(string: fullPath)!)
        print(fullPath)
        session.dataTask(with: request) {[weak self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data else { return }
            switch (httpResponse.statusCode) {
            case 200...300:
                do {
                    let results = try JSONDecoder().decode(T.self, from: receivedData)
                    successHandler(results)
                } catch {
                    print("")
                }
            case 400:
                break
            default:
                break
            }
        }.resume()
    }
}
 
