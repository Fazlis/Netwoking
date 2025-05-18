//
//  LoggerInterface.swift
//  Netwoking
//
//  Created by Fazliddinov Iskandar on 18/05/25.
//

import Foundation


public protocol LoggerInterface {
    func logRequest(_ request: URLRequest)
    func logResponse(
        _ response: URLResponse?,
        data: Data?,
        error: Error?,
        duration: TimeInterval
    )
}
