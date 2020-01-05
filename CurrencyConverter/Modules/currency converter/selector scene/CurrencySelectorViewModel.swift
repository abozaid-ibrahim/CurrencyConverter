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
    var showProgress: Observable<Bool> { get }
    var currencyValuesList: Observable<CurrencyModel> { get }
    var currenciesList: Observable<[String]> { get }
    var error: Observable<Error> { get }
    func loadCurrencyOf(cur: String)
    func itemSelected(of c: (String, String))
}

typealias CurrencyModel = [String: String]
final class CurrencySelectorListViewModel: CurrencySelectorViewModel {
    private let apiClient: ApiClient

    // MARK: private state

    private let disposeBag = DisposeBag()
    private let _currencyValuesList = PublishSubject<CurrencyModel>()
    private let _showProgress = PublishSubject<Bool>()
    private let _error = PublishSubject<Error>()
    private var currencyValuesCach: [String: Float] = [:]
    private var base = ""

    // MARK: Observers

    var currenciesList: Observable<[String]> {
        return _currencyValuesList.map { $0.map { $0.key } }
    }

    var showProgress: Observable<Bool> {
        return _showProgress.asObservable()
    }

    var currencyValuesList: Observable<CurrencyModel> {
        return _currencyValuesList.asObservable()
    }

    var error: Observable<Error> {
        return _error.asObservable()
    }

    init(apiClient: ApiClient = HTTPClient()) {
        self.apiClient = apiClient
    }

    func itemSelected(of c: (String, String)) {
        try! AppNavigator().push(.currencyCalculator(base: base, toCurrency: c.0, value: Float(c.1)!))
    }

    func loadCurrencyOf(cur: String) {
        base = cur
        guard currencyValuesCach.isEmpty else {
            calculateCurrency(for: cur)
            return
        }
        _showProgress.onNext(true)
        let api = CurrencySelectorApi.latest(currency: cur)
        apiClient.getData(of: api) { result in
            switch result {
            case let .success(data):
                self.parseData(with: data)
            case let .failure(error):
                log(.error, error.localizedDescription)
                self._error.onNext(error)
            }
            self._showProgress.onNext(false)
        }
    }

    private func calculateCurrency(for currency: String) {
        guard let value = currencyValuesCach[currency] else { return }
        var newValues: [String: Float] = [:]
        for item in currencyValuesCach {
            let newValue = item.1
            newValues[item.key] = newValue / value
        }
        newValues["EUR"] = 1 / value
        newValues.removeValue(forKey: currency)
        publish(newValues)
    }

    private func parseData(with data: Data) {
        log(.info, String(data: data, encoding: .utf8))
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(CurrencySelectorResponse.self, from: data)
            currencyValuesCach = model.rates
            publish(model.rates)
        } catch {
            log(.error, error)
            _error.onNext(NetworkFailure.failedToParseData)
        }
    }

    private func publish(_ dic: [String: Float]) {
        let valu = dic.mapValues { String(Float(round(100 * $0) / 100)) }
        _currencyValuesList.onNext(valu)
    }
}
