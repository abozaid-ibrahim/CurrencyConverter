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
    // MARK: IBuilder

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var baseLbl: UILabel!
    @IBOutlet private var baseCurrencyView: UIView!

    // MARK: State

    private let disposeBag = DisposeBag()
    private let dropdown = DropdownViewController()
    var viewModel: CurrencySelectorViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Currency converter"
        tableView.registerNib(CurrencyTableCell.self)
        bindToViewModel()
        viewModel.loadCurrencyOf(cur: "EUR")
    }

    @IBAction private func onBaseCurrencyTapped(_ sender: Any) {
        dropdown.itemSelected.subscribe(onNext: { [unowned self] selected in
            self.baseLbl.text = selected
            self.viewModel.loadCurrencyOf(cur: selected)
        }).disposed(by: disposeBag)
        dropdown.modalPresentationStyle = .overCurrentContext
        present(dropdown, animated: true, completion: nil)
    }

    private func bindToViewModel() {
        viewModel.currencyValuesList
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: CurrencyTableCell.self), cellType: CurrencyTableCell.self)) { _, element, cell in

                cell.setData(currency: element.key, value: element.value)
            }
            .disposed(by: disposeBag)
        viewModel.currenciesList.bind(onNext: dropdown.setData(data:)).disposed(by: disposeBag)

        tableView.rx.modelSelected((String, String).self)
            .subscribe(onNext: { [unowned self] value in
                self.viewModel.itemSelected(of: value)
            }).disposed(by: disposeBag)
    }
}
