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
    }

    private func setupTableVeiw() {
        tableView.register(UINib(nibName: CurrencyTableCell.id, bundle: .none), forCellReuseIdentifier: CurrencyTableCell.id)

        let items = Observable.just(
            (0 ..< 20).map { "\($0)" }
        )
        items
            .bind(to: tableView.rx.items(cellIdentifier: CurrencyTableCell.id, cellType: CurrencyTableCell.self)) { row, element, cell in
                cell.setData(value: "\(element) @ row \(row)")
            }
            .disposed(by: disposeBag)
    }
}
