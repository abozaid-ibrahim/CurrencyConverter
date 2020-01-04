//
//  FreeLeaksModuelsTests.swift
//  CurrencyConverterTests
//
//  Created by Abuzeid on 1/4/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

@testable import CurrencyConverter
import Nimble
import Quick
import SpecLeaks
final class FreeLeaksModuelsTests: QuickSpec {
    override func spec() {
        describe("MyViewController") {
            describe("must not leak") {
                it("categories Module") {
                    let vc = LeakTest {
                        Destination.currencySelector.controller()
                    }
                    expect(vc).toNot(leak())
                }
                it("categoriy items Module") {
                    let vc = LeakTest {
                        Destination.currencyCalculator(base: "EUR", toCurrency: "USD", value: 1.2).controller()
                    }
                    expect(vc).toNot(leak())
                }
            }
        }
    }
}
