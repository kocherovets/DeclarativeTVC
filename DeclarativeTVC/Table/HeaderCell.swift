//
//  HeaderCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
}

struct HeaderCellVM: CellModel {

    let titleText: String?

    func apply(to cell: HeaderCell) {

        cell.titleLabel.text = titleText
    }
}
