//
//  Endpoint.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//


import Foundation


public protocol Endpoint {
    associatedtype Response: Decodable
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

public extension Endpoint {
    var headers: [String: String]? { return nil }
    var queryItems: [URLQueryItem]? { return nil }
    var body: Data? { return nil }
}
