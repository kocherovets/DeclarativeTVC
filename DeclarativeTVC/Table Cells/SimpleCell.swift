//
//  SimpleCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class SimpleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
}

struct SimpleCellVM: CellModel {

    let titleText: String?

    func apply(to cell: SimpleCell) {

        cell.titleLabel.text = titleText
    }
}
