//
//  CurrencySelectorDestination.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/2/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation
import UIKit
extension Destination {
    func getSelectorView() -> UIViewController {
        let controller = CurrencySelectorViewController()
        controller.viewModel = CurrencySelectorListViewModel()
        return controller
    }
}
