//
//  BaseHTTPClient.swift
//  Networking
//
//  Created by Dustin Sapp on 2/12/25.
//

import Foundation

@available(iOS 15.0, *)
@available(macOS 12.0, *)
/// Base HTTP client for handling HTTP network requests
public final class BaseHTTPClient: HTTPClient {
    private let urlSession: URLSession
    /// Creates a `BaseHTTPClient` from the specified parameters
    ///
    /// - Parameters:
    ///   - urlSession: a `Foundation` `URLSession` defaults to shared instance
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// Starts a request for receiving data via HTTP network call. Returns: `Data` and `HTTPURLResponse`
    ///
    /// - Parameters:
    ///  - request: a request conforming to the `NetworkRequestProtocol`
    public func startDataRequest(for request: HTTPRequest) async throws -> (Data, HTTPURLResponse) {
        guard let url = request.url else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        request.headers.forEach { key, value in urlRequest.addValue(value, forHTTPHeaderField: key) }
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.invalidHTTPResponse(response) }
        
        return (data, httpResponse)
    }
    
    /// Starts a request for submitting data via HTTP network call. Returns: `Data` and `HTTPURLResponse`
    ///
    /// - Parameters:
    ///  - request: a request conforming to the `NetworkRequestProtocol`.
    ///  - data: The data for submission.
    @discardableResult
    public func startUploadRequest(for request: HTTPRequest, _ data: Data) async throws -> (Data, HTTPURLResponse) {
        guard let url = request.url else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        request.headers.forEach { key, value in urlRequest.addValue(value, forHTTPHeaderField: key) }
        
        let (data, response) = try await URLSession.shared.upload(for: urlRequest, from: data)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.invalidHTTPResponse(response) }
        
        return (data, httpResponse)
    }
}
