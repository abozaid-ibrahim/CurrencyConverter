//
//  CurrencySelectorViewModel.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation
import RxSwift
protocol CurrencySelectorViewModel {
}

struct CurrencySelectorListViewModel: CurrencySelectorViewModel {
    var apiClient: ApiClient
    init(apiClient: ApiClient = HTTPClient()) {
        self.apiClient = apiClient
    }
    func loadCurrencyOf(cur:String){
        
    }
    
}
