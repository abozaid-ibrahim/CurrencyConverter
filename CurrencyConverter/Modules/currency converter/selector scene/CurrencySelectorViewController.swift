//
//  CurrencySelectorViewController.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class CurrencySelectorViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    var viewModel: CurrencySelectorViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableVeiw()
        setupTableVeiw()
        bindToViewModel()
        viewModel.loadCurrencyOf(cur: "EUR")
    }

    private func setupSelectorView() {
        title = "Title"
    }

    private func bindToViewModel() {
        viewModel.currenciesList
            .bind(to: tableView.rx.items(cellIdentifier: CurrencyTableCell.id, cellType: CurrencyTableCell.self)) { _, element, cell in

                cell.setData(currency: element.key, value: element.value)
            }
            .disposed(by: disposeBag)
        tableView.rx.modelSelected((String, String).self).subscribe(onNext: { [unowned self] value in
            self.title = value.0
            self.viewModel.loadCurrencyOf(cur: value.0)
        }).disposed(by: disposeBag)
    }

    private func setupTableVeiw() {
        tableView.register(UINib(nibName: CurrencyTableCell.id, bundle: .none), forCellReuseIdentifier: CurrencyTableCell.id)
    }
}
