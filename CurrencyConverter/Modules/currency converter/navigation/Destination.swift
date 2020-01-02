//
//  Destination.swift
//  CurrencyConverter
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit
enum Destination {
    case currencySelector,
        currencyCalculator(base: String, value: Float)

    func controller() -> UIViewController {
        switch self {
        case .currencySelector:
            return getSelectorView()
        case let .currencyCalculator(base, value):
            return getCurrencyCalculatorView(of: base, value: value)
        }
    }
}
