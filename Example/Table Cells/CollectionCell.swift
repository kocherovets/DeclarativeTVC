//
//  SimpleCell.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class CollectionCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
}

struct CollectionCellVM: CellModel {
    
    let items: [ColorCellVM]
    
    private let collectionDS = CollectionDS()

    func apply(to cell: CollectionCell, containerView: UIScrollView) {

        collectionDS.set(collectionView: cell.collectionView, items: items, animated: false)
    }
}

extension CollectionCellVM: Equatable {
    
    static func == (lhs: CollectionCellVM, rhs: CollectionCellVM) -> Bool {
        return lhs.items == rhs.items
    }
}
