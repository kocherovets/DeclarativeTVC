//
//  VerticalCVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class VerticalCVC: CVC {

    override func data() -> Data {

        switch state.detailType {
        case .simpleCollection:
            return .items(coloredItems())
        case .simpleCollection2:
            return .items(coloredItems2())
        default:
            return .items([])
        }
    }
}

extension VerticalCVC {

    private func coloredItems() -> [CellAnyModel] {
        [
            ColorSelectableCellVM(color: UIColor.systemRed,
                                  selectCommand: Command {
                                      state.detailType = .simpleCollection2
                                      self.reload()
                                  }),
            ColorCellVM(color: UIColor.systemGreen),
            ColorCellVM(color: UIColor.systemBlue),
            ColorCellVM(color: UIColor.systemOrange),
            ColorCellVM(color: UIColor.systemYellow),
            ColorCellVM(color: UIColor.systemPink),
            ColorCellVM(color: UIColor.systemPurple),
            ColorCellVM(color: UIColor.systemTeal),
            ColorCellVM(color: UIColor.systemIndigo),
        ]
    }

    private func coloredItems2() -> [CellAnyModel] {
        [
            ColorSelectableCellVM(color: UIColor.systemRed,
                                  selectCommand: Command {
                                      state.detailType = .simpleCollection
                                      self.reload()
                                  }),
            ColorCellVM(color: UIColor.systemGreen),
            ColorCellVM(color: UIColor.systemBlue),
            ColorCellVM(color: UIColor.systemOrange),
            ColorCellVM(color: UIColor.systemYellow),
            ColorCellVM(color: UIColor.systemPink),
            ColorCellVM(color: UIColor.systemPurple),
            ColorCellVM(color: UIColor.systemTeal),
            ColorCellVM(color: UIColor.systemIndigo),

            ColorCellVM(color: UIColor.systemRed),
            ColorCellVM(color: UIColor.systemGreen),
            ColorCellVM(color: UIColor.systemBlue),
            ColorCellVM(color: UIColor.systemOrange),
            ColorCellVM(color: UIColor.systemYellow),
            ColorCellVM(color: UIColor.systemPink),
            ColorCellVM(color: UIColor.systemPurple),
            ColorCellVM(color: UIColor.systemTeal),
            ColorCellVM(color: UIColor.systemIndigo),

            ColorCellVM(color: UIColor.systemRed),
            ColorCellVM(color: UIColor.systemGreen),
            ColorCellVM(color: UIColor.systemBlue),
            ColorCellVM(color: UIColor.systemOrange),
            ColorCellVM(color: UIColor.systemYellow),
            ColorCellVM(color: UIColor.systemPink),
            ColorCellVM(color: UIColor.systemPurple),
            ColorCellVM(color: UIColor.systemTeal),
            ColorCellVM(color: UIColor.systemIndigo),

            ColorCellVM(color: UIColor.systemRed),
            ColorCellVM(color: UIColor.systemGreen),
            ColorCellVM(color: UIColor.systemBlue),
            ColorCellVM(color: UIColor.systemOrange),
            ColorCellVM(color: UIColor.systemYellow),
            ColorCellVM(color: UIColor.systemPink),
            ColorCellVM(color: UIColor.systemPurple),
            ColorCellVM(color: UIColor.systemTeal),
            ColorCellVM(color: UIColor.systemIndigo),

            ColorCellVM(color: UIColor.systemRed),
            ColorCellVM(color: UIColor.systemGreen),
            ColorCellVM(color: UIColor.systemBlue),
            ColorCellVM(color: UIColor.systemOrange),
            ColorCellVM(color: UIColor.systemYellow),
            ColorCellVM(color: UIColor.systemPink),
            ColorCellVM(color: UIColor.systemPurple),
            ColorCellVM(color: UIColor.systemTeal),
            ColorCellVM(color: UIColor.systemIndigo),

            ColorCellVM(color: UIColor.systemRed),
            ColorCellVM(color: UIColor.systemGreen),
            ColorCellVM(color: UIColor.systemBlue),
            ColorCellVM(color: UIColor.systemOrange),
            ColorCellVM(color: UIColor.systemYellow),
            ColorCellVM(color: UIColor.systemPink),
            ColorCellVM(color: UIColor.systemPurple),
            ColorCellVM(color: UIColor.systemTeal),
            ColorCellVM(color: UIColor.systemIndigo),
        ]
    }
}

