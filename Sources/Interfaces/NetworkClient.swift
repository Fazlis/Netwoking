//
//  NetworkClient.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//


public protocol NetworkClient {
    func send<R: NetworkRequest>(_ request: R) async throws -> R.Response
    func loadMockResponse<Response: Decodable>(fileName: String) async throws -> Response
}
