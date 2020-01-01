//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation

public protocol RequestBuilder {
    var baseURL: String { get }

    var method: HttpMethod { get }

    var parameters: [String: Any] { get }
    var task: URLRequest { get }
}

public enum HttpMethod: String {
    case get, post
}

extension RequestBuilder {
    var description: String {
        return "\(endpoint), \(parameters)"
    }

    var endpoint: URL {
        return URL(string: "\(baseURL)")!
    }

    var baseURL: String {
        return APIConstants.baseURL
    }

    var task: URLRequest {
        var items = [URLQueryItem]()
        var myURL = URLComponents(string: endpoint.absoluteString)
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: "\(value)"))
        }
        myURL?.queryItems = items
        var request = URLRequest(url: myURL!.url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
        request.httpMethod = method.rawValue
        return request
    }
}
