//
//  TableModel.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import DifferenceKit
import UIKit

public struct TableSection {
    public let header: TableHeaderAnyModel?
    public let footer: TableFooterAnyModel?
    public var rows: [CellAnyModel]

    fileprivate var orderNumber: Int = 0

    public init(header: TableHeaderAnyModel?, rows: [CellAnyModel], footer: TableFooterAnyModel?) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }
}

extension TableSection {
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

public struct TableModel: Equatable {
    public var sections: [TableSection]

    public static func == (lhs: TableModel, rhs: TableModel) -> Bool {
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
            if lhs.sections[i].rows.count != rhs.sections[i].rows.count {
                return false
            }

            for ii in 0 ..< lhs.sections[i].rows.count {
                if lhs.sections[i].rows[ii].innerEquatableValue() != rhs.sections[i].rows[ii].innerEquatableValue() {
                    return false
                }
            }
        }

        return true
    }

    public init(sections: [TableSection]) {
        self.sections = sections

        for i in 0 ..< self.sections.count {
            self.sections[i].orderNumber = i
        }
    }

    public init(rows: [CellAnyModel]) {
        sections = [TableSection(header: nil, rows: rows, footer: nil)]
    }
}
