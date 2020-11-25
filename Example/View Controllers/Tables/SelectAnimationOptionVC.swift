//
//  SelectAnimationOptionVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class SelectAnimationOptionVC: TVC {

    override func data() -> Data {
            .rows(
                UITableView.RowAnimation.allCases.map { rowAnimation in
                    CheckedCellVM(titleText: rowAnimation.title,
                                  checked: state.selectedAnymationTypeValue() == rowAnimation,
                                  selectCommand: Command { [weak self] in
                                      state.setSelectedAnymationTypeValue(rowAnimation)
                                      self?.navigationController?.popViewController(animated: true)
                                  })
                }
            )
    }
}
