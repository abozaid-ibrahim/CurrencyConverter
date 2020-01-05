//
//  SelectorViewModel.swift
//  CurrencyConverterTests
//
//  Created by Abuzeid on 1/5/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

@testable import CurrencyConverter
import Nimble
import Quick
import RxNimble
import RxSwift
import RxTest

final class SelectorViewModelTests: QuickSpec {
    override func spec() {
        describe("selector view model") {
            var schedular: TestScheduler!
            var currenciesObserver: TestableObserver<CurrencyModel>!
            var disposeBag = DisposeBag()
            var viewModel: CurrencySelectorViewModel!

            beforeEach {
                schedular = TestScheduler(initialClock: 0)
                currenciesObserver = schedular.createObserver(CurrencyModel.self)
                disposeBag = DisposeBag()
            }

            it("should calculate the values of other currencies") {
                viewModel = CurrencySelectorListViewModel(apiClient: MockedApiClient())

                viewModel.currencyValuesList.bind(to: currenciesObserver).disposed(by: disposeBag)
                viewModel.loadCurrencyOf(cur: "EUR")
                schedular.start()
                expect(currenciesObserver.events)
                    .to(equal(
                        [Recorded.next(0, ["AED": "4.12", "USD": "2.0", "EGP": "6.12"])]
                    ))
                viewModel.loadCurrencyOf(cur: "USD")
                expect(currenciesObserver.events.last)
                    .to(equal(
                        Recorded.next(0, ["AED": "2.06", "EGP": "3.06", "EUR": "0.5"])
                    ))
            }
        }
    }
}

fileprivate class MockedApiClient: ApiClient {
    func getData(of request: RequestBuilder, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let data = """
        {
        "success": true,
        "timestamp": 1577874305,
        "base": "EUR",
        "date": "2020-01-01",
        "rates": {
        "AED": 4.12,"USD":2.0,"EGP":6.12}
        }
        """.data(using: .utf8)!
        completionHandler(Result<Data, Error>.success(data))
    }
}
