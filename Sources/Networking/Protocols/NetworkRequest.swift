//
//  NetworkRequest.swift
//  Networking
//
//  Created by Dustin Sapp on 2/23/25.
//

import Foundation

/// A protocol for any API requets sent to any HTTP client
public protocol APIRequest {
    ///
    associatedtype APIEndpoint: Endpoint
    /// Headers for the request
    var headers: [String: String]? { get set }
    /// Parameters for the request
    var parameters: [String: String]? { get set }
    /// Path of the request confoming to `Endpoint`
    var path: APIEndpoint { get }
    /// The HTTP request method
    var method: HTTPMethod { get }
}

/// Default values
extension APIRequest {
    
    var headers: [String: String]? {
        nil
    }
    
    var parameters: [String: String]? {
        nil
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.path = path.endpoint
        components.queryItems = parameters?.map { key, value in URLQueryItem(name: key, value: value)}
        return components.url
    }
}
