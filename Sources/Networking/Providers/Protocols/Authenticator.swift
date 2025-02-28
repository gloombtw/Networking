//
//  File.swift
//  Networking
//
//  Created by Dustin Sapp on 2/26/25.
//

import Foundation

public protocol Authenticator {
    var isAuthenticated: Bool { get }
}
