//
//  NetworkError.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation
enum NetworkFailure: LocalizedError, Equatable {
    case unAcceptedResponse(String), failedToParseData, connectionFailed, noData, badRequest
    var errorDescription: String? {
        switch self {
        case .failedToParseData:
            return "Technical Difficults, we can't fetch the data"
        case let .unAcceptedResponse(err):
            return "unexpected response: \(err)"
        case .connectionFailed:
            return "Check your connectivity"
        case .noData:
            return "there is no data"
        case .badRequest:
            return "something is missing, you have bad request"
        }
    }
}
