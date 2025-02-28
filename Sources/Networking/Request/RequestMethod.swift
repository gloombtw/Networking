//
//  RequestMethod.swift
//  Networking
//
//  Created by Dustin Sapp on 2/23/25.
//

import Foundation

/// An enumeration of HTTP request methods.
public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}
