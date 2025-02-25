//
//  NetworkRequest.swift
//  Networking
//
//  Created by Dustin Sapp on 2/23/25.
//

import Foundation

/// A network request needing to provide a URL. 
public protocol NetworkRequest {
    var url: URL? { get }
}
