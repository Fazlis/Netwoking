//
//  RequestBuilder.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//


import Foundation
import Interfaces


public struct RequestBuilder {
    public static func buildRequest<E: Endpoint>(from endpoint: E) -> URLRequest {
        
        var url = URL(string: endpoint.baseURL)!
        
        var fullPathUrl = url.appendingPathComponent(endpoint.path)
        
        if let queryItems = endpoint.queryItems, var components = URLComponents(url: fullPathUrl, resolvingAgainstBaseURL: false) {
            components.queryItems = queryItems
            fullPathUrl = components.url ?? fullPathUrl
        }

        var request = URLRequest(url: fullPathUrl)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        return request
    }
}
