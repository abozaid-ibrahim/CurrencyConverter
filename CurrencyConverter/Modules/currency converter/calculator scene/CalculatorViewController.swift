//
//  CalculatorViewController.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/2/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import RxCocoa
import RxOptional
import RxSwift
import UIKit

class CalculatorViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: CalculatorViewModel!
    
    @IBOutlet private var currencyLbl: UILabel!
    @IBOutlet private var baseTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        baseTextField.rx.text
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .filterNil()
            .debug()
            .map { Float($0) }
            .filterNil()
            .subscribe(onNext: { [unowned self] value in
                self.viewModel.calculateCurrencyValue(of: value)
            }).disposed(by: disposeBag)

        viewModel.currencyValue.bind(to: currencyLbl.rx.text).disposed(by: disposeBag)
    }
}
