//
//  AnimationTypeSelectCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class AnimationTypeSelectCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
}

struct AnimationTypeSelectCellVM: CellModel, SelectableCellModel {

    let titleText: String
    let valueText: String
    let selectCommand: Command

    func apply(to cell: AnimationTypeSelectCell) {

        cell.titleLabel.text = titleText
        cell.valueLabel.text = valueText
    }
}
