//
//  TableHeaderModel.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

open class XibTableViewHeaderFooterView: UITableViewHeaderFooterView {
}

open class CodedTableViewHeaderFooterView: UITableViewHeaderFooterView {
}

public protocol TableHeaderAnyModel {
    
    static var headerAnyType: UIView.Type { get }
    
    func apply(to header: UIView)
    
    func innerHashValue() -> Int
    
    func innerEquatableValue() -> Int

    func innerRowAnimationEquatableValue() -> Int

    func cellType() -> CellKind
    
    func register(tableView: UITableView, identifier: String)
    
    func height(tableFrame: CGRect) -> CGFloat?
}

public protocol TableHeaderModel: TableHeaderAnyModel, Hashable {
    
    associatedtype HeaderType: UIView
    
    func apply(to header: HeaderType)
    
    func cellType() -> CellKind
}

public extension TableHeaderModel {
    
    static var headerAnyType: UIView.Type {
        return HeaderType.self
    }
    
    func apply(to header: UIView) {
        apply(to: header as! HeaderType)
    }
    
    func innerHashValue() -> Int {
        return hashValue
    }
    
    func innerEquatableValue() -> Int {
        innerRowAnimationEquatableValue()
    }

    func innerRowAnimationEquatableValue() -> Int {
        hashValue
    }

    func cellType() -> CellKind {
        switch HeaderType.self {
        case is XibTableViewHeaderFooterView.Type:
            return .xib
        case is CodedTableViewHeaderFooterView.Type:
            return .code
        default:
            return .storyboard
        }
    }
    
    func register(tableView: UITableView, identifier: String) {
        
        tableView.register(HeaderType.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func height(tableFrame: CGRect) -> CGFloat? {
        nil
    }
}

public struct TitleWithoutViewTableHeaderModel: TableHeaderModel {
    
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    public func apply(to header: UITableViewHeaderFooterView) {
        
    }
}
