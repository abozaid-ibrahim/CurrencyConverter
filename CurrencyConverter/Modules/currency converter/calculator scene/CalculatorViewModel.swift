//
//  CalculatorViewModel.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/2/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import Foundation
import RxSwift

protocol CalculatorViewModel {
    var totalValue: Observable<String> { get }
    func calculateCurrencyValue(of: Float)
}

struct CalculatorFormViewModel: CalculatorViewModel {
    // MARK: private state

    private let disposeBag = DisposeBag()
    private let _totalValue = PublishSubject<String>()
    private let currency: Float

    // MARK: Observers

    var totalValue: Observable<String> {
        return _totalValue.asObservable()
    }

    init(base: String, value: Float) {
        currency = value
    }

    func calculateCurrencyValue(of amount: Float) {
        let sum = amount * currency
        _totalValue.onNext(String(sum))
    }
}
