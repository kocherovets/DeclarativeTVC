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
    
    func apply(to header: UIView, containerView: UIScrollView)
    
    func innerHashValue() -> Int
    
    func innerEquatableValue() -> Int

    func innerAnimationEquatableValue() -> Int

    func cellKind() -> CellKind
    
    func register(tableView: UITableView, identifier: String)
    
    func height(containerView: UIScrollView) -> CGFloat?

    var reuseIdentifier: String? { get }
    
    var bundle: Bundle? { get }
}

public protocol TableHeaderModel: TableHeaderAnyModel, Hashable {
    
    associatedtype HeaderType: UIView
    
    func apply(to header: HeaderType, containerView: UIScrollView)
    
    func cellKind() -> CellKind
}

public extension TableHeaderModel {
    
    static var headerAnyType: UIView.Type {
        return HeaderType.self
    }
    
    func apply(to header: UIView, containerView: UIScrollView) {
        apply(to: header as! HeaderType, containerView: containerView)
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

    func cellKind() -> CellKind {
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
    
    func height(containerView: UIScrollView) -> CGFloat? {
        nil
    }
    
    var reuseIdentifier: String? { nil }
    
    var bundle: Bundle? { nil }
}

public struct TitleWithoutViewTableHeaderModel: TableHeaderModel {
    
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    public func apply(to header: UITableViewHeaderFooterView, containerView: UIScrollView) {
        
    }
}
