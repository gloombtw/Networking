//
//  File.swift
//  Networking
//
//  Created by Dustin Sapp on 2/12/25.
//

import Foundation

@available(iOS 15.0, *)
@available(macOS 12.0, *)
public final class BaseHTTPClient: HTTPClient {
    private let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    public func startDataRequest(for request: HTTPRequest) async throws -> (Data, HTTPURLResponse) {
        guard let url = request.url else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        request.headers.forEach { key, value in urlRequest.addValue(value, forHTTPHeaderField: key) }
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.invalidHTTPResponse(response) }
        
        return (data, httpResponse)
    }
    
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
