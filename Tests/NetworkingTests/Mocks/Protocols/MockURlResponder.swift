//
//  MockURLResponder.swift
//  Networking
//
//  Created by Dustin Sapp on 2/24/25.
//

import Foundation

package protocol MockURlResponder {
    static func data(for request: URLRequest) throws -> Data
    static func upload(for request: URLRequest, data: Data) throws -> (Data, URLResponse)
}
