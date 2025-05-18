//
//  NetworkLogger.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//
import Foundation
import Interfaces


public struct NetworkLogger: LoggerInterface {
    
    private var isEnabled: Bool

    public init(isEnabled: Bool = true) {
        self.isEnabled = isEnabled
    }

    public func logRequest(_ request: URLRequest) {
        guard isEnabled else { return }

        var output = "\n🌐 [REQUEST] \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")"

        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            output += "\n📬 Headers:\n" + headers.map { "  \($0.key): \($0.value)" }.joined(separator: "\n")
        }

        if let body = request.httpBody,
           let bodyString = prettyPrintJSON(body) {
            output += "\n📦 Body:\n\(bodyString)"
        }

        print(output + "\n")
    }

    public func logResponse(_ response: URLResponse?, data: Data?, error: Error?, duration: TimeInterval) {
        guard isEnabled else { return }

        var output = "\n💾 [RESPONSE]"
        if let httpResponse = response as? HTTPURLResponse {
            output += " \(httpResponse.statusCode) \(httpResponse.url?.absoluteString ?? "")"
        }

        output += String(format: " (%.2fs)", duration)

        if let data = data,
           let bodyString = prettyPrintJSON(data) {
            output += "\n📥 Response Body:\n\(bodyString)"
        }

        if let error = error {
            output += "\n⛔️ Error: \(error.localizedDescription)"
        }

        print(output + "\n")
    }

    private func prettyPrintJSON(_ data: Data) -> String? {
        guard let object = try? JSONSerialization.jsonObject(with: data),
              let jsonData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyString = String(data: jsonData, encoding: .utf8) else {
            return String(data: data, encoding: .utf8)
        }
        return prettyString
    }
}
