//
//  ColorCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class ColorCell: UICollectionViewCell {

    @IBOutlet weak var coloredV: UIView!
}

struct ColorCellVM: CellModel {

    let color: UIColor?

    func apply(to cell: ColorCell) {

        cell.coloredV.backgroundColor = color
    }
}
