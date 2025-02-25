//
//  NetworkClientRequest.swift
//  Networking
//
//  Created by Dustin Sapp on 2/23/25.
//

import Foundation

public struct HTTPRequest: NetworkRequest {
    public let headers: [String: String]
    
    public private(set) var url: URL?
    
    public init(
        endPoint: String,
        headers: [String: String],
        queryParameters: [String : String],
        path: String,
        method: RequestMethod
    ) {
        self.headers = headers

        self.url = {
            var components = URLComponents()
            components.scheme = method.rawValue
            components.host = endPoint
            components.path = path
            components.queryItems = queryParameters.map { key, value in URLQueryItem(name: key, value: value) }
            return components.url
        }()
    }
}
