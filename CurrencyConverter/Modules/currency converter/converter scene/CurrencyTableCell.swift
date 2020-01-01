//
//  CurrencyTableCell.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import UIKit

final class CurrencyTableCell: UITableViewCell {
    static let id = "CurrencyTableCell"
    @IBOutlet private var currencyLbl: UILabel!
    func setData(value: String) {
        currencyLbl.text = value
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
