//
//  CollectionModel.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DifferenceKit

public struct CollectionSection {

    public let header: CollectionHeaderAnyModel?
    public let footer: CollectionFooterAnyModel?
    public var items: [CollectionCellAnyModel]

    fileprivate var orderNumber: Int = 0
    
    public init(header: CollectionHeaderAnyModel?, items: [CollectionCellAnyModel], footer: CollectionFooterAnyModel?) {
        self.header = header
        self.items = items
        self.footer = footer
    }
}

extension CollectionSection {
    var cellDifferentiable: CellDifferentiable {
        var hashValue = orderNumber
        var contentEquatableValue = orderNumber
        if let hash = header?.innerHashValue() {
            hashValue = hash
            contentEquatableValue = hash
        }
        if let contentEquatable = header?.innerAnimationEquatableValue() {
            contentEquatableValue = contentEquatable
        }
        return CellDifferentiable(hash: hashValue,
                                  contentEquatable: contentEquatableValue)
    }
}

public struct CollectionModel: Equatable {

    public var sections: [CollectionSection]

    public static func == (lhs: CollectionModel, rhs: CollectionModel) -> Bool {
        if lhs.sections.count != rhs.sections.count {
            return false
        }

        for i in 0 ..< lhs.sections.count {
            if lhs.sections[i].header?.innerEquatableValue() != rhs.sections[i].header?.innerEquatableValue() {
                return false
            }
            if lhs.sections[i].footer?.innerEquatableValue() != rhs.sections[i].footer?.innerEquatableValue() {
                return false
            }
        }

        for i in 0 ..< lhs.sections.count {
            if lhs.sections[i].items.count != rhs.sections[i].items.count {
                return false
            }

            for ii in 0 ..< lhs.sections[i].items.count {
                if lhs.sections[i].items[ii].innerEquatableValue() != rhs.sections[i].items[ii].innerEquatableValue() {
                    return false
                }
            }
        }

        return true
    }

    public init(sections: [CollectionSection]) {

        self.sections = sections

        for i in 0 ..< self.sections.count {
            self.sections[i].orderNumber = i
        }
    }

    public init(items: [CollectionCellAnyModel]) {

        self.sections = [CollectionSection(header: nil, items: items, footer: nil)]
    }
}
