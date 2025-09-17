//
//  NetworkError.swift
//  Networking
//
//  Created by Dustin Sapp on 2/23/25.
//

import Foundation

/// An enumeration of possbile network error scenarios. 
public enum NetworkError: Error, CustomStringConvertible {
    case invalidURL
    case invalidHTTPResponse(URLResponse)
    case taskCanceled
    
    public var description: String {
        switch self {
        case .invalidURL:
            return "Unable to build URL"
        case .invalidHTTPResponse(let response):
            return "Response returned: \(response)"
        case .taskCanceled:
            return "Task was canceled"
        }
    }
}
