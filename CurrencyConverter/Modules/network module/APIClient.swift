//
//  APIClient.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation
protocol ApiClient {
    func getData(of request: RequestBuilder, completionHandler: @escaping (Result<Data, Error>) -> Void)
}

final class HTTPClient: ApiClient {
    func getData(of request: RequestBuilder, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request.task) { data, response, error in
            log(.info, request.description)
            log(.info, data.toString)

            if let error = error {
                log(.error, error.localizedDescription)
                completionHandler(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200 ... 299).contains(httpResponse.statusCode) else {
                log(.error, "Status Code:\((response as? HTTPURLResponse)?.statusCode ?? 0)")
                completionHandler(.failure(NetworkFailure.unAcceptedResponse("out of success response range")))
                return
            }
            if let _data = data {
                completionHandler(.success(_data))
            } else {
                completionHandler(.failure(NetworkFailure.noData))
            }
        }
        task.resume()
    }
}

extension Optional where Wrapped == Data {
    var toString: String {
        guard let empty = "".data(using: .utf8) else { return "" }
        return String(data: self ?? empty, encoding: .utf8) ?? ""
    }
}
