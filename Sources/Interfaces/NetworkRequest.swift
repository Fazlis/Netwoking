//
//  NetworkRequest.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//


import Foundation


public protocol NetworkRequest {
    associatedtype Response: Decodable
    var urlRequest: URLRequest { get }
}