//
//  CurrencyTableCell.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import UIKit

final class CurrencyTableCell: UITableViewCell {
    @IBOutlet private var currencyLbl: UILabel!
    @IBOutlet private var valueLbl: UILabel!

    func setData(currency: String, value: String) {
        currencyLbl.text = currency
        valueLbl.text = value
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
