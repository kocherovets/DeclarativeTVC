//
//  CellModel.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DifferenceKit

extension Int: Differentiable {}

protocol CellAnyModel {
    
    static var cellAnyType: UITableViewCell.Type { get }
    
    func apply(to cell: UITableViewCell)
    
    func innerHashValue() -> Int
}

protocol CellModel: CellAnyModel, Hashable, Differentiable {
    
    associatedtype CellType: UITableViewCell

    func apply(to cell: CellType)
}

extension CellModel {
    
    static var cellAnyType: UITableViewCell.Type {
        return CellType.self
    }
    
    func apply(to cell: UITableViewCell) {
         apply(to: cell as! CellType)
    }
    
    func innerHashValue() -> Int {
        return hashValue
    }
}
