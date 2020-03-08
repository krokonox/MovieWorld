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
    
    private var URLParameters: [String: String] {
        return ["api_key" : api_key]
    }
   
    private var dataTask: URLSessionDataTask?
    
    private lazy var session = URLSession(configuration: .default)
    
    func request<T: Decodable>(urlPath: String,
                               successHandler: @escaping(_ response: T) -> Void,
                               errorHandler: @escaping(Error) -> Void) {
        
        let url = "\(baseURL)\(urlPath)"
        let fullPath = getUrlWithParams(fullPath: url, params: URLParameters)
        
        guard let fullURL = URL(string: fullPath) else {
            errorHandler(MWError.incorrectUrl)
            return
        }
        
        let request = URLRequest(url: fullURL)
        
        session.dataTask(with: request) { [weak self] data, response, error in
            
            if error != nil {
                self?.handleErrors(errorHandler: errorHandler, error: MWError.networkError)
            }

            guard let httpResponse = response as? HTTPURLResponse,
                let receivedData = data else {
                    self?.handleErrors(errorHandler: errorHandler, error: MWError.networkError)
                    return
            }
            
            switch (httpResponse.statusCode) {
            case 200...300:
                do {
                    let result = try JSONDecoder().decode(T.self, from: receivedData)
                    DispatchQueue.main.async {
                        successHandler(result)
                    }
                } catch {
                    self?.handleErrors(errorHandler: errorHandler, error: MWError.parsingError)
                }
            case 401:
                errorHandler(MWError.serverError)
            case 404:
                errorHandler(MWError.serverError)
            default:
                errorHandler(MWError.unknown)
            }
        }.resume()
    }
    
    private func handleErrors(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }
}
 
