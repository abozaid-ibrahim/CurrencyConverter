//
//  Pageable.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation
import Foundation

final class Page {
    var currentPage: Int = 1
    var maxPages: Int = 2
    var countPerPage: Int = 12
    var isFetchingData = false
    var fetchedItemsCount = 0
    var shouldLoadMore: Bool {
        return (currentPage <= maxPages) && (!isFetchingData)
    }
}
