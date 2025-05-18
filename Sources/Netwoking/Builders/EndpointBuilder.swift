//
//  EndpointBuilder.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//


import Foundation
import Interfaces


public struct EndpointBuilder<E: Endpoint>: NetworkRequest {
    
    public typealias Response = E.Response
    
    private let endpoint: E
    
    public var urlRequest: URLRequest {
        RequestBuilder.buildRequest(from: endpoint)
    }
    
    public init(endpoint: E) {
        self.endpoint = endpoint
    }
}
