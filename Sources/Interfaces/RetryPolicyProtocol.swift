//
//  RetryPolicyProtocol.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//


import Foundation


public protocol RetryPolicyProtocol {
    func shouldRetry(for error: NetworkError) async -> Bool
    var maxRetries: Int { get }
}


/*
 USAGE CAN BE LIKE
 
 struct DefaultRetryPolicy: RetryPolicy {
     let maxRetries = 1
     func shouldRetry(for error: Error) -> Bool {
         if case NetworkError.httpError(let code, _) = error, code == 401 {
             return true
         }
         return false
     }
 }
 
 */
