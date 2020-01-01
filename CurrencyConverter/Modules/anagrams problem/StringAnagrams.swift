//
//  StringAnagrams.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation
extension String {
    func isAnagram(to value: String) -> Bool {
        return value.lowercased().sorted() == lowercased().sorted()
    }
}
