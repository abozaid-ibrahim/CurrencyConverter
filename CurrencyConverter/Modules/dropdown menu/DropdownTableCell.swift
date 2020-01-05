//
//  DropdownTableCell.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/5/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import UIKit

final class DropdownTableCell: UITableViewCell {
    @IBOutlet private var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setData(_ value: String) {
        titleLbl.text = value
    }
}
