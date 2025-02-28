//
//  HTTPRequest.swift
//  Networking
//
//  Created by Dustin Sapp on 2/23/25.
//

import Foundation

/// A struct represneting an HTTP request
public struct HTTPRequest: NetworkRequest {
    /// Optional headers for the request
    public let headers: [String: String]?
    /// Read only URL
    public private(set) var url: URL?
    /// Creates a `HTTPRequest` from the specified parameters
    ///
    ///  - Parameters:
    ///   - endPoint: The request endpoint
    ///   - headers: Optional headers for the request
    ///   - queryParameters: Optional query parameters for the request
    ///   - path: The enpoint's path
    ///   - method: The HTTP method for the request
    public init(
        endPoint: String,
        headers: [String: String]? = [:],
        queryParameters: [String : String]? = [:],
        path: String,
        method: RequestMethod
    ) {
        self.headers = headers

        self.url = {
            var components = URLComponents()
            components.scheme = method.rawValue
            components.host = endPoint
            components.path = path
            components.queryItems = queryParameters?.map { key, value in URLQueryItem(name: key, value: value) }
            return components.url
        }()
    }
}
