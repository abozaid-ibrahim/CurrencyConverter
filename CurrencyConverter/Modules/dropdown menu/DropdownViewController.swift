//
//  DropdownViewController.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/4/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import RxOptional
import RxSwift
import UIKit
final class DropdownViewController: UIViewController {
    /// private state
    @IBOutlet private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private let _itemSelected = PublishSubject<String>()
    private(set) var dataList: [String]!

    /// output
    var itemSelected: Observable<String> {
        _itemSelected.asObservable()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    private func configureTableView() {
        tableView.registerNib(DropdownTableCell.self)
        Observable.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: DropdownTableCell.self), cellType: DropdownTableCell.self)) { _, element, cell in
                cell.setData(element)
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: { [unowned self] value in
                self._itemSelected.onNext(value)
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }

    func setData(data: [String]) {
        dataList = data
    }
}
