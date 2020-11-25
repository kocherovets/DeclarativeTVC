//
//  MainVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class MainVC: TVC {

    override func data() -> Data {
            .rows(
                [
                    HeaderCellVM(titleText: "Tables"),
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
                    SimpleSelectableCellVM(
                        titleText: "Storyboard, xib and code rows",
                        selectCommand: Command() {
                            state.detailType = .tableRowThreeTypes
                            self.show(DetailVC.self)
                        }),
                    SimpleSelectableCellVM(
                        titleText: "Many sections with headers and footers",
                        selectCommand: Command() {
                            state.detailType = .tableManySections
                            self.show(DetailVC.self)
                        }),
                    SimpleSelectableCellVM(
                        titleText: "Grouped table",
                        selectCommand: Command() {
                            self.show(GroupedTVC.self)
                        }),

                    HeaderCellVM(titleText: "Collections"),
                    SimpleSelectableCellVM(
                        titleText: "Vertical collection",
                        selectCommand: Command() {
                            state.detailType = .simpleCollection
                            self.show(VerticalCVC.self)
                        }),
                    SimpleSelectableCellVM(
                        titleText: "Horizontal collection",
                        selectCommand: Command() {
                            state.detailType = .simpleCollection
                            self.show(HorizontalCVC.self)
                        }),
                    
                    HeaderCellVM(titleText: "Table & Collection"),
                    SimpleSelectableCellVM(
                        titleText: "Horizontal collection as table row",
                        selectCommand: Command() {
                            self.show(CollectionRowVC.self)
                        }),
                ]
            )
    }
}
