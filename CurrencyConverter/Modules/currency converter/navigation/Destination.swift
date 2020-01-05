//
//  Destination.swift
//  CurrencyConverter
//
//  Created by abuzeid on 1/4/20.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit
enum Destination {
    case currencySelector,
        currencyCalculator(base: String, toCurrency: String, value: Float)

    func controller() -> UIViewController {
        switch self {
        case .currencySelector:
            return getSelectorView()
        case let .currencyCalculator(base, currency, value):
            return getCurrencyCalculatorView(of: base, currency: currency, value: value)
        }
    }
}
