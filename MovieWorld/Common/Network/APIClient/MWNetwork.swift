//
//  NetworkInterface.swift
//  MovieWorld
//
//  Created by Admin on 29/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

typealias MWNet = MWNetwork

class MWNetwork {
    
    // MARK: - Variables
    
    static let sh = MWNetwork()
 
    private let baseURL = "https://api.themoviedb.org/3/"
    
    private(set) public var apiKey = "79d5894567be5b76ab7434fc12879584"
    private var urlParameters: [String: String] {
        return ["api_key": apiKey]
    }
    private var dataTask: URLSessionDataTask?
    
    private lazy var session = URLSession(configuration: .default)
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Request function
    
    func request<T: Decodable>(urlPath: String,
                               parameters: [String: String]? = nil,
                               successHandler: @escaping (_ response: T) -> Void,
                               errorHandler: @escaping (MWError) -> Void) {
        
        let url = "\(baseURL)\(urlPath)"
 
        var urlComponents: URLComponents? {
            var components = URLComponents(string: url)
            
            var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
            
            if let params = parameters {
                queryItems.append(contentsOf: params.map {
                    return URLQueryItem(name: "\($0)", value: "\($1)")
                })
            }
            components?.queryItems = queryItems
            return components
        }
        
        guard let components = urlComponents?.url else { return }
        print(components)
        let request = URLRequest(url: components)
        
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
    
    private func handleErrors(errorHandler: @escaping (_ error: MWError) -> Void, error: MWError) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }
}

