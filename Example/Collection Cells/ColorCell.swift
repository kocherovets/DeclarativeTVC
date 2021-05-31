//
//  ColorCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import DeclarativeTVC
import UIKit

class ColorCell: UICollectionViewCell {
    @IBOutlet var coloredV: UIView!
}

struct ColorCellVM: CollectionCellModel {
    let color: UIColor?

    func apply(to cell: ColorCell, containerView: UIScrollView) {
        cell.coloredV.backgroundColor = color
    }

    func size(containerView: UIScrollView) -> CGSize? {
        CGSize(width: 50, height: 50)
    }
}
