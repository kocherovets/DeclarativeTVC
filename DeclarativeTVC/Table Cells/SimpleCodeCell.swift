//
//  SimpleCodeCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 08.12.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class SimpleCodeCell: CodedTableViewCell {

}

struct SimpleCodeCellVM: CellModel {

    let titleText: String?

    func apply(to cell: SimpleCodeCell) {

        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = titleText
    }
    
    var height: CGFloat? { 200 }
}
