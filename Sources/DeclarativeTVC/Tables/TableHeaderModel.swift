//
//  TableHeaderModel.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

public protocol TableHeaderAnyModel {
    
    static var headerAnyType: UIView.Type { get }
    
    func apply(to header: UIView)
    
    func innerHashValue() -> Int
    
    func innerContentEquatableValue() -> Int

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
    
    func innerContentEquatableValue() -> Int {
        return hashValue
    }

    func cellType() -> CellKind {
        switch HeaderType.self {
        case is XibTableViewCell.Type, is XibCollectionViewCell.Type:
            return .xib
        case is CodedTableViewCell.Type, is CodedCollectionViewCell.Type:
            return .code
        case is UITableViewCell.Type, is UICollectionViewCell.Type, is StoryboardTableViewCell.Type, is StoryboardCollectionViewCell.Type:
            return .storyboard
        default:
            return .notCell
        }
    }
    
    func register(tableView: UITableView, identifier: String) {
        
        tableView.register(HeaderType.self, forCellReuseIdentifier: identifier)
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
}
