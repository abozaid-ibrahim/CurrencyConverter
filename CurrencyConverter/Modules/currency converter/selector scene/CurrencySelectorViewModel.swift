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
    var currenciesList: Observable<CurrencyModel> { get }
    var error: Observable<Error> { get }
    func loadCurrencyOf(cur: String)
    func itemSelected(of c: (String, String))
}

typealias CurrencyModel = [String: String]
struct CurrencySelectorListViewModel: CurrencySelectorViewModel {
    private let apiClient: ApiClient

    // MARK: private state

    private let disposeBag = DisposeBag()
    private let _categories = PublishSubject<CurrencyModel>()
    private let _showProgress = PublishSubject<Bool>()
    private let _error = PublishSubject<Error>()
    private let base = "EUR"

    // MARK: Observers

    var showProgress: Observable<Bool> {
        return _showProgress.asObservable()
    }

    var currenciesList: Observable<CurrencyModel> {
        return _categories.asObservable()
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
        _showProgress.onNext(true)
        let api = CurrencySelectorApi.latest(currency: cur)
        apiClient.getData(of: api) { result in
            switch result {
            case let .success(data):
                self.updateUI(with: data)
            case let .failure(error):
                log(.error, error.localizedDescription)
                self._error.onNext(error)
            }
            self._showProgress.onNext(false)
        }
    }

    private func updateUI(with data: Data) {
        log(.info, String(data: data, encoding: .utf8))
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(CurrencySelectorResponse.self, from: data)
            let valu = model.rates.mapValues { String(Float(round(100 * $0) / 100)) }
            _categories.onNext(valu)
        } catch {
            log(.error, error)
            _error.onNext(NetworkFailure.failedToParseData)
        }
    }
}
