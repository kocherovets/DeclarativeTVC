//
//  HeaderView.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class HeaderView: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

}

struct HeaderViewVM: TableHeaderModel {

    let titleText: String?

    func apply(to header: HeaderView, containerView: UIScrollView) {
        
        header.titleLabel.text = titleText
    }
}

struct FooterViewVM: TableFooterModel {

    let titleText: String?
    let h: CGFloat

    func apply(to footer: HeaderView, containerView: UIScrollView) {
        
        footer.titleLabel.text = titleText
    }
    
    func height(tableFrame: CGRect) -> CGFloat? { h }
}

