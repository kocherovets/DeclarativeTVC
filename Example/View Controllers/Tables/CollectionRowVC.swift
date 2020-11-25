//
//  CollectionRowVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class CollectionRowVC: TVC {

    override func data() -> Data {
            .rows(
                [
                    HeaderCellVM(titleText: "Header 1"),
                    SimpleCellVM(titleText: "Paragraph 1 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
                    SimpleCellVM(titleText: "Paragraph 2 jsdklf aslfj "),
                    CollectionCellVM(items: [
                        ColorCellVM(color: UIColor.systemRed),
                        ColorCellVM(color: UIColor.systemGreen),
                        ColorCellVM(color: UIColor.systemBlue),
                        ColorCellVM(color: UIColor.systemOrange),
                        ColorCellVM(color: UIColor.systemYellow),
                        ColorCellVM(color: UIColor.systemPink),
                        ColorCellVM(color: UIColor.systemPurple),
                        ColorCellVM(color: UIColor.systemTeal),
                        ColorCellVM(color: UIColor.systemIndigo),
                    ]),
                    SimpleCellVM(titleText: "Paragraph 3 jsdklf aslfj aksldfj askldfsalk fjlaks falksfdaslfj lkasfdjals kfda;ls dflkas fdlkasfasl")
                ]
            )
    }
}
