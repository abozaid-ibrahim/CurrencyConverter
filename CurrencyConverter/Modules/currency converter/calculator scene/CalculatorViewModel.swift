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
    var baseCurrency: Observable<String> { get }
    var toCurrency: Observable<String> { get }
    func calculateCurrencyValue(of: Float)
}

struct CalculatorFormViewModel: CalculatorViewModel {
    // MARK: private state

    private let disposeBag = DisposeBag()
    private let _totalValue = PublishSubject<String>()
    private let currencyValue: Float

    // MARK: Observers

    let baseCurrency: Observable<String>
    let toCurrency: Observable<String>
    var totalValue: Observable<String> {
        return _totalValue.asObservable()
    }

    init(base: String, currency: String, value: Float) {
        baseCurrency = Observable.of(base)
        toCurrency = Observable.of(currency)
        currencyValue = value
    }

    func calculateCurrencyValue(of amount: Float) {
        let sum = amount * currencyValue
        _totalValue.onNext(String(sum))
    }
}
