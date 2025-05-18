//
//  AsyncNetworkClient.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//


import Foundation
import Interfaces


public class AsyncNetworkClient: NetworkClient {
    
    private var logger: LoggerInterface
    
    public init(logger: LoggerInterface) {
        self.logger = logger
    }
    
    public func send<R: NetworkRequest>(_ request: R) async throws -> R.Response {
        
        logger.logRequest(request.urlRequest)
        
        let requestStartedTime = Date()
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request.urlRequest)
            
            let requestDuration = Date().timeIntervalSince(requestStartedTime)
            
            logger.logResponse(
                response,
                data: data,
                error: nil,
                duration: requestDuration
            )
            
            try validate(response: response, data: data)
            
            return try JSONDecoder().decode(R.Response.self, from: data)
            
        } catch let decodingError as DecodingError {
            
            let requestDuration = Date().timeIntervalSince(requestStartedTime)
            
            logger.logResponse(
                nil,
                data: nil,
                error: decodingError,
                duration: requestDuration
            )
            throw NetworkError.decodingError(decodingError)
        } catch {
            let requestDuration = Date().timeIntervalSince(requestStartedTime)
            
            logger.logResponse(
                nil,
                data: nil,
                error: error,
                duration: requestDuration
            )
            throw NetworkError.transportError(error)
        }
    }

    private func validate(response: URLResponse, data: Data?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(httpResponse.statusCode, data)
        }
    }
}
