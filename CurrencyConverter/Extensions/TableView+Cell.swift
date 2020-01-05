//
//  TableView+Cell.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/4/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {
    /// wrapper to register cell in a short line
    /// - Parameter name: the cell identifier
    func registerNib(_ name: UITableViewCell.Type) {
        register(UINib(nibName: String(describing: name.self), bundle: .none),
                 forCellReuseIdentifier: String(describing: name.self))
    }

    static var identifier: String {
       return String(describing:self )
    }
}
