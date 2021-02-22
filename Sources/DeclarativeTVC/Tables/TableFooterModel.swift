//
//  TableFooterModel.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

public protocol TableFooterAnyModel {

    static var footerAnyType: UIView.Type { get }

    func apply(to footer: UIView)

    func innerHashValue() -> Int

    func innerEquatableValue() -> Int

    func innerAnimationEquatableValue() -> Int

    func cellType() -> CellKind
    
    func register(tableView: UITableView, identifier: String)
    
    func height(tableFrame: CGRect) -> CGFloat?
}

public protocol TableFooterModel: TableFooterAnyModel, Hashable {

    associatedtype FooterType: UIView

    func apply(to footer: FooterType)

    func cellType() -> CellKind
}

public extension TableFooterModel {

    static var footerAnyType: UIView.Type {
        return FooterType.self
    }

    func apply(to footer: UIView) {
        apply(to: footer as! FooterType)
    }

    func innerHashValue() -> Int {
        return hashValue
    }

    func innerEquatableValue() -> Int {
        innerAnimationEquatableValue()
    }

    func innerAnimationEquatableValue() -> Int {
        hashValue
    }

    func cellType() -> CellKind {
        switch FooterType.self {
        case is XibTableViewHeaderFooterView.Type:
            return .xib
        case is CodedTableViewHeaderFooterView.Type:
            return .code
        default:
            return .storyboard
        }
    }
    
    func register(tableView: UITableView, identifier: String) {
        
        tableView.register(FooterType.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func height(tableFrame: CGRect) -> CGFloat? {
        nil
    }
}

public struct TitleWithoutViewTableFooterModel: TableFooterModel {
    
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
}
