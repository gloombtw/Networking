//
//  BaseHTTPClient.swift
//  Networking
//
//  Created by Dustin Sapp on 2/12/25.
//

import Foundation

/// Base HTTP client for handling HTTP network requests
open class BaseHTTPClient<Request: APIRequest>: HTTPClient {
    private let urlSession: URLSession
    /// Creates a `BaseHTTPClient` from the specified parameters
    ///
    /// - Parameters:
    ///   - urlSession: a `Foundation` `URLSession` defaults to .shared
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// Starts a request for receiving data via HTTP network call. Returns: `Data` and `HTTPURLResponse`
    ///
    /// - Parameters:
    ///  - request: a request conforming to the `NetworkRequestProtocol`
    public func startDataRequest(for request: Request) async throws -> (Data, HTTPURLResponse) {
        guard let url = request.url else { throw NetworkError.invalidURL }

        var urlRequest = URLRequest(url: url)
        request.headers?.forEach { key, value in urlRequest.addValue(value, forHTTPHeaderField: key) }
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard !Task.isCancelled else { throw NetworkError.taskCanceled }
        
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.invalidHTTPResponse(response) }
        
        return (data, httpResponse)
    }
    
    /// Starts a request for submitting data via HTTP network call. Returns: `Data` and `HTTPURLResponse`
    ///
    /// - Parameters:
    ///  - request: a request conforming to the `NetworkRequestProtocol`.
    ///  - data: The data for submission.
    @discardableResult
    public func startUploadRequest(for request: Request, _ data: Data) async throws -> (Data, HTTPURLResponse) {
        guard let url = request.url else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        request.headers?.forEach { key, value in urlRequest.addValue(value, forHTTPHeaderField: key) }
        
        let (data, response) = try await URLSession.shared.upload(for: urlRequest, from: data)
        
        guard !Task.isCancelled else { throw NetworkError.taskCanceled }
        
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.invalidHTTPResponse(response) }
        
        return (data, httpResponse)
    }
}
