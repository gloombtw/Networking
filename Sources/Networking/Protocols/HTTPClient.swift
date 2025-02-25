///
/// HTTPClient.Swift
/// Networking
///
/// Created by Dustin Sapp on 2/20/2025
///
import Foundation

/// A simple HTTP Client Protocol for sending and receiving HTTP calls.
@available(iOS 13.0.0, *)
public protocol HTTPClient {
    /// Flexible network request type conforming to the `NetworkRequest` Protocol
    associatedtype Request: NetworkRequest

    func startDataRequest(for request: Request) async throws -> (Data, HTTPURLResponse)
    func startUploadRequest(for request: Request, _ data: Data) async throws -> (Data, HTTPURLResponse)
}
