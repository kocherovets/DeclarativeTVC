//
//  SimpleXibCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.12.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class SimpleXibCell: XibTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

struct SimpleXibCellVM: CellModel {

    let titleText: String?

    func apply(to cell: SimpleXibCell) {

        cell.titleLabel.text = titleText
    }
}
