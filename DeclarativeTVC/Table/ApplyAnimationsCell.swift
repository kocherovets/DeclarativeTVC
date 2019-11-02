//
//  ApplyAnimationsCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class ApplyAnimationsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
}

struct ApplyAnimationsCellVM: CellModel, SelectableCellModel {

    let titleText: String
    let selectCommand: Command

    func apply(to cell: ApplyAnimationsCell) {

        cell.titleLabel.text = titleText
    }
}

