//
//  FibonacciCalculator.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation
final class FibonacciCalculator {
    private var fibMemoList: [Int: UInt] = [:]

    func getFibonacci(of number: Int, callback: @escaping ([Int: UInt]) -> Void) {
        // TODO: Use NSThread to change stack size and accept bigger numbers
        DispatchQueue.global().sync { [weak self] in
            guard let self = self else { return }
            _ = try? self.fibonacciRecursivly(of: number)
            callback(self.fibMemoList)
        }
    }

    
    private func fibonacciRecursivly(of number: Int) throws -> UInt {
        /// base
        guard number != 0, number != 1 else {
            fibMemoList[number] = UInt(number)
            return UInt(number)
        }
        // calculated Before
        if let value2 = fibMemoList[number - 1] {
            if let value1 = fibMemoList[number - 2] {
                let value = value2.addingReportingOverflow(value1)
                if value.overflow {
                    throw Err.overflow
                } else {
                    fibMemoList[number] = value.partialValue
                    return value.partialValue
                }
            }
        }
        // calculate New
        guard let value = try? fibonacciRecursivly(of: number - 1).addingReportingOverflow(fibonacciRecursivly(of: number - 2)) else {
            throw Err.overflow
        }

        if value.overflow {
            throw Err.overflow
        } else {
            fibMemoList[number] = value.partialValue
            return value.partialValue
        }
    }
}

enum Err: Error {
    case overflow
}
