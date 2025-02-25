//
//  NetworkRequest.swift
//  Networking
//
//  Created by Dustin Sapp on 2/23/25.
//

import Foundation

public protocol NetworkRequest {
    var url: URL? { get }
}
