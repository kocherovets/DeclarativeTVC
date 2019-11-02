//
//  CheckedCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class CheckedCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
}

struct CheckedCellVM: CellModel, SelectableCellModel {

    let titleText: String
    let checked: Bool
    let selectCommand: Command

    func apply(to cell: CheckedCell) {

        cell.titleLabel.text = titleText
        cell.accessoryType = checked ? .checkmark : .none
    }
}
