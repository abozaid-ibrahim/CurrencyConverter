//
//  BundleExtension.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//
import Foundation

extension Bundle {
    func decode<T: Decodable>(_: T.Type, from file: String) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw NetworkFailure.badRequest
        }

        guard let data = try? Data(contentsOf: url) else {
            throw NetworkFailure.noData
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            log(.error, error)
            throw NetworkFailure.failedToParseData
        }
    }
}
