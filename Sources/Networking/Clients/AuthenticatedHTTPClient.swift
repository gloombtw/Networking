//
//  File.swift
//  Networking
//
//  Created by Dustin Sapp on 2/26/25.
//

import Foundation

public final class AuthenticatedHTTPClient: HTTPClient {
    private let authService: Authenticator
    private let urlSession: URLSession

    public init(authService: Authenticator = AuthenticationService(), urlSession: URLSession = .shared) {
        self.authService = authService
        self.urlSession = urlSession
    }

    public func startDataRequest(for request: HTTPRequest) async throws -> (Data, HTTPURLResponse) {
        if authService.isAuthenticated {
            guard let url = request.url else { throw NetworkError.invalidURL }
            
            var urlRequest = URLRequest(url: url)
            request.headers?.forEach { key, value in urlRequest.addValue(value, forHTTPHeaderField: key) }
            
            let (data, response) = try await urlSession.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.invalidHTTPResponse(response) }
            
            return (data, httpResponse)
        }
        throw NetworkError.userNotAuthenticated
    }

    @discardableResult
    public func startUploadRequest(for request: HTTPRequest, _ data: Data) async throws -> (Data, HTTPURLResponse) {
        if authService.isAuthenticated {
            guard let url = request.url else { throw NetworkError.invalidURL }
            
            var urlRequest = URLRequest(url: url)
            request.headers?.forEach { key, value in urlRequest.addValue(value, forHTTPHeaderField: key) }
            
            let (data, response) = try await URLSession.shared.upload(for: urlRequest, from: data)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.invalidHTTPResponse(response) }
            
            return (data, httpResponse)
        }
        throw NetworkError.userNotAuthenticated
    }
}
