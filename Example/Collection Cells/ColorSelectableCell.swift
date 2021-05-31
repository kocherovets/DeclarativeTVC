//
//  ColorCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import DeclarativeTVC
import UIKit

class ColorSelectableCell: UICollectionViewCell {
    @IBOutlet var coloredV: UIView!
}

struct ColorSelectableCellVM: CollectionCellModel, SelectableCellModel {
    let color: UIColor?
    let selectCommand: Command

    func apply(to cell: ColorSelectableCell, containerView: UIScrollView) {
        cell.coloredV.backgroundColor = color
    }

    func size(containerView: UIScrollView) -> CGSize? {
        CGSize(width: 50, height: 50)
    }
}
