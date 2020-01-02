//
//  CalculatorDestination.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/2/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation
import UIKit

extension Destination {
    func getCurrencyCalculatorView(of base: String, value: Float) -> UIViewController {
        let controller = CalculatorViewController()
        let viewModel = CalculatorFormViewModel(base: base, value: value)
        controller.viewModel = viewModel
        return controller
    }
}
