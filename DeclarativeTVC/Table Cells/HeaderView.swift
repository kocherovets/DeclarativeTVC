//
//  HeaderView.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class HeaderView: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

}

struct HeaderViewVM: TableHeaderModel {

    let titleText: String?

    func apply(to header: HeaderView) {
        
        header.titleLabel.text = titleText
    }
}
