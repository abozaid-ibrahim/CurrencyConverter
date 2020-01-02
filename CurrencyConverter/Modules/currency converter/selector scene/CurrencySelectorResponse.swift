//
//  CurrencySelectorResponse.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation
struct CurrencySelectorResponse: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String:Float]
}
