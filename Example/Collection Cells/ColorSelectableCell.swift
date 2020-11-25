//
//  ColorCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class ColorSelectableCell: UICollectionViewCell {

    @IBOutlet weak var coloredV: UIView!
}

struct ColorSelectableCellVM: CellModel, SelectableCellModel {

    let color: UIColor?
    let selectCommand: Command

    func apply(to cell: ColorSelectableCell) {

        cell.coloredV.backgroundColor = color
    }
}
