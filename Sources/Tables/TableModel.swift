//
//  TableModel.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DifferenceKit

struct TableSection {

    let header: TableHeaderAnyModel?
    let footer: TableFooterAnyModel?
    var rows: [CellAnyModel]

    fileprivate var orderNumber: Int = 0
    
    init(header: TableHeaderAnyModel?, rows: [CellAnyModel], footer: TableFooterAnyModel?) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }
}

extension String: Differentiable { }

extension TableSection: Differentiable {

    var differenceIdentifier: String {
        if let hash = header?.innerHashValue() {
            return String(hash)
        }
        return "Section \(orderNumber)"
    }

    func isContentEqual(to source: TableSection) -> Bool {
        return differenceIdentifier == source.differenceIdentifier
    }
}

struct TableModel: Equatable {

    var sections: [TableSection]

    static func == (lhs: TableModel, rhs: TableModel) -> Bool {

        if lhs.sections.count != rhs.sections.count {
            return false
        }

        for i in 0 ..< lhs.sections.count {

            if lhs.sections[i].rows.count != rhs.sections[i].rows.count {
                return false
            }

            for ii in 0 ..< lhs.sections[i].rows.count {
                if lhs.sections[i].rows[ii].innerHashValue() != rhs.sections[i].rows[ii].innerHashValue() {
                    return false
                }
            }
        }

        return true
    }

    init(sections: [TableSection]) {

        self.sections = sections
        
        for i in 0 ..< self.sections.count {
            self.sections[i].orderNumber = i
        }
    }

    init(rows: [CellAnyModel]) {

        self.sections = [TableSection(header: nil, rows: rows, footer: nil)]
    }
}
