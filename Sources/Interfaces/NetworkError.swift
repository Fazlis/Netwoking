//
//  NetworkError.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//


import Foundation


public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case httpError(Int, Data?)
    case transportError(Error)
    case unknown
}
