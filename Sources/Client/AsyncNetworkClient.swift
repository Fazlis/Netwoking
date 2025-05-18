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
    
    public func loadMockResponse<Response: Decodable>(fileName: String) async throws -> Response {
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print("Файл \(fileName).json не найден")
            throw NSError(domain: "MockFileError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Файл \(fileName).json не найден"])
        }
        
        do {
            let fileURL = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: fileURL)
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            print("✅ Моковый ответ из \(fileName).json успешно загружен")
            return decodedResponse
        } catch {
            print("Ошибка при чтении мокового файла \(fileName): \(error)")
            throw error
        }
    }
}
