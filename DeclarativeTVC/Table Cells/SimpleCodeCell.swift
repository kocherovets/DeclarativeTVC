//
//  SimpleCodeCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 08.12.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class SimpleCodeCell: CodeTableViewCell {

}

struct SimpleCodeCellVM: CellModel {

    let titleText: String?

    func apply(to cell: SimpleCodeCell) {

        cell.textLabel?.text = titleText
    }
}
