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
    var currencyValue: Observable<String> { get }
    func calculateCurrencyValue(of: Float)
}

struct CalculatorFormViewModel: CalculatorViewModel {
    // MARK: private state

    private let disposeBag = DisposeBag()
    private let _currencyValue = BehaviorSubject<String>(value: "1")

    // MARK: Observers

    var currencyValue: Observable<String> {
        return _currencyValue.asObservable()
    }

    func calculateCurrencyValue(of: Float) {
        _currencyValue.onNext("22")
    }
}
