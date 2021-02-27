//
//  SelectAnimationsCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class SelectAnimationsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var animationLabel: UILabel!
}

struct SelectAnimationsCellVM: CellModel, SelectableCellModel {

    let titleText: String
    let animationText: String
    let selectCommand: Command

    func apply(to cell: SelectAnimationsCell, containerView: UIScrollView) {

        cell.titleLabel.text = titleText
        cell.animationLabel.text = animationText
    }
}
