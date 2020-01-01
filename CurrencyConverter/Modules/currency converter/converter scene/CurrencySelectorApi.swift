//
//  CurrencySelectorApi.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation

enum CategoryApi {
    case latest(currency: String)
}

extension CategoryApi: RequestBuilder {
    var parameters: [String: Any] {
        switch self {
        case let .latest(currency):
            return ["base": currency,
                    "api_key": APIConstants.apiKey,
                    "format": "1",
            ]
        }
    }

    var method: HttpMethod {
        switch self {
        case .latest:
            return .get
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
