//
//  FibonacciTests.swift
//  CurrencyConverterTests
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

@testable import CurrencyConverter
import XCTest
class FibonacciTests: XCTestCase {
    var calculator: FibonacciCalculator!

    override func setUp() {
        calculator = FibonacciCalculator()
    }

    override func tearDown() {
        calculator = nil
    }

    func testFibonacciOfZero() {
        let oneRecurseExp = XCTestExpectation(description: "zero_rec")
        let oneIterativeExp = XCTestExpectation(description: "zero_iter")
        calculator.getFibonacci(of: 0, type: CalculationType.recurse, callback: { fibonacciList in
            XCTAssert(fibonacciList.count == 1)
            XCTAssertEqual(fibonacciList[0], 0)
            oneRecurseExp.fulfill()
        })
        calculator.getFibonacci(of: 0, type: CalculationType.iterative, callback: { fibonacciList in
            XCTAssert(fibonacciList.count == 1)
            XCTAssertEqual(fibonacciList[0], 0)
            oneIterativeExp.fulfill()
        })
        wait(for: [oneRecurseExp, oneIterativeExp], timeout: 0.1)
    }

    func testFibonacciOfOne() {
        let twoElementExpectation = XCTestExpectation(description: "one")
        let twoIterativeExp = XCTestExpectation(description: "zero_iter")

        calculator.getFibonacci(of: 1, type: CalculationType.recurse, callback: { fibonacciList in
            XCTAssertEqual(fibonacciList[1], 1)
            twoElementExpectation.fulfill()
        })
        calculator.getFibonacci(of: 1, type: CalculationType.iterative, callback: { fibonacciList in
            XCTAssertEqual(fibonacciList.count, 2)
            XCTAssertEqual(fibonacciList[1], 1)
            twoIterativeExp.fulfill()
        })
        wait(for: [twoElementExpectation, twoIterativeExp], timeout: 0.1)
    }

    func testValidFibonacci() {
        let randomElementExpectation = XCTestExpectation(description: "many")
        let raandomIterativeExp = XCTestExpectation(description: "r_iter")

        calculator.getFibonacci(of: 10, type: CalculationType.recurse, callback: { fibonacciList in
            XCTAssertEqual(fibonacciList.count, 11)
            XCTAssertEqual(fibonacciList[10], 55)
            randomElementExpectation.fulfill()
        })
        calculator.getFibonacci(of: 10, type: CalculationType.iterative, callback: { fibonacciList in
            XCTAssertEqual(fibonacciList.count, 11)
            XCTAssertEqual(fibonacciList[10], 55)
            raandomIterativeExp.fulfill()
        })
        wait(for: [randomElementExpectation, raandomIterativeExp], timeout: 3.0)
    }
}
