//
//  SimpleSelectableCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class SimpleSelectableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
}

struct SimpleSelectableCellVM: CellModel, SelectableCellModel {

    let titleText: String
    let selectCommand: Command

    func apply(to cell: SimpleSelectableCell) {

        cell.titleLabel.text = titleText
    }
}
