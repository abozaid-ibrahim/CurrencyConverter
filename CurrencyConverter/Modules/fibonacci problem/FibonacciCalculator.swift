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

    func getFibonacci(of number: UInt, type: CalculationType, callback: @escaping ([Int: UInt]) -> Void) {
        // TODO: Use NSThread to change stack size and accept bigger numbers
        DispatchQueue.global().sync { [weak self] in
            guard let self = self else { return }
            if type == .recurse {
                _ = try? self.fibonacciRecursivly(of: Int(number))
                callback(self.fibMemoList)
            } else {
                let fib = self.fibonacciIteratively(of: number)
                callback(fib)
            }
        }
    }

    private func fibonacciIteratively(of number: UInt) -> [Int: UInt] {
        var fibsList: [Int: UInt] = [:]

        fibsList[0] = 0
        var fib: UInt = 0 // 0
        var prev: UInt = 1 //

        var item = 1
        while item <= number {
            let tempPrev = fib
            fib = prev + fib
            prev = tempPrev
            fibsList[Int(item)] = fib
            item += 1
        }

        return fibsList
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

enum CalculationType {
    case iterative, recurse
}
