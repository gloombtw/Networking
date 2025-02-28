//
//  File.swift
//  Networking
//
//  Created by Dustin Sapp on 2/26/25.
//

import Foundation

public final class AuthenticationService: Authenticator {
    public private(set) var isAuthenticated: Bool
    
    public init(isAuthenticated: Bool = true) {
        self.isAuthenticated = isAuthenticated
    }
}
