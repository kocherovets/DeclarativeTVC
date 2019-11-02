//
//  MainVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class MainVC: VC {

    override func data() -> Data {
            .rows(
                [
                    SimpleSelectableCellVM(
                        titleText: "Several table cell types",
                        selectCommand: Command() {
                            state.detailType = .severalCellTypes
                            self.show(DetailVC.self)
                        }),
                    SimpleSelectableCellVM(
                        titleText: "Table Animations",
                        selectCommand: Command() {
                            state.detailType = .tableAnimations
                            self.show(DetailVC.self)
                        }),
                    SimpleSelectableCellVM(
                        titleText: "Table Sections",
                        selectCommand: Command() {
                            state.detailType = .tableSections
                            self.show(DetailVC.self)
                        }),
                    SimpleSelectableCellVM(
                        titleText: "Table Sections Animations",
                        selectCommand: Command() {
                            state.detailType = .tableWithSections
                            self.show(DetailVC.self)
                        }),
                    SimpleSelectableCellVM(
                        titleText: "Table row editing",
                        selectCommand: Command() {
                            state.detailType = .tableRowEditing
                            self.show(DetailVC.self)
                        }),
                ]
            )
    }
}
