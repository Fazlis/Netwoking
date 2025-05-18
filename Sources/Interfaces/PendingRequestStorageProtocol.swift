//
//  PendingRequestStorageProtocol.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//


import Foundation

public protocol PendingRequestStorageProtocol {
    var pending: [() async throws -> Void] { get }
    
    func add<R: NetworkRequest>(_ request: R, using client: NetworkClient) async
    
    func retryAll() async
}