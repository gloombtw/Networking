//
//  File.swift
//  Networking
//
//  Created by Dustin Sapp on 2/23/25.
//

import Foundation

public enum NetworkError: Error, CustomStringConvertible {
    case invalidURL
    case invalidHTTPResponse(URLResponse)
    
    public var description: String {
        switch self {
        case .invalidURL:
            return "Unable to build URL"
        case .invalidHTTPResponse(let response):
            return "Response returned: \(response)"
        }
    }
}
