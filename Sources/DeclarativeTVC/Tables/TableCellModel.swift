//
//  CellModel.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import DifferenceKit
import UIKit

extension Int: Differentiable {}

open class StoryboardTableViewCell: UITableViewCell {
}

open class XibTableViewCell: UITableViewCell {
}

open class CodedTableViewCell: UITableViewCell {
}

public enum CellKind {
    case storyboard
    case xib
    case code
}

public struct CellDifferentiable: Differentiable {
    public func isContentEqual(to source: CellDifferentiable) -> Bool {
        contentEquatable == source.contentEquatable
    }

    public var differenceIdentifier: DifferenceIdentifier { hash }

    public typealias DifferenceIdentifier = Int

    let hash: Int
    let contentEquatable: Int
}

public protocol CellAnyModel {
    static var cellAnyType: UIView.Type { get }

    func apply(to cell: UIView, containerView: UIScrollView)

    func innerHashValue() -> Int

    func innerEquatableValue() -> Int

    func innerAnimationEquatableValue() -> Int

    func cellKind() -> CellKind

    func cellType() -> UIView.Type

    func register(tableView: UITableView, identifier: String)

    func height(containerView: UIScrollView) -> CGFloat?
    
    var reuseIdentifier: String? { get }

    var bundle: Bundle? { get }
}

public protocol CellModel: CellAnyModel, Hashable, Differentiable {
    associatedtype CellType: UIView

    func apply(to cell: CellType, containerView: UIScrollView)

    func cellKind() -> CellKind

    func cellType() -> UIView.Type
}

public extension CellModel {
    static var cellAnyType: UIView.Type {
        return CellType.self
    }

    func apply(to cell: UIView, containerView: UIScrollView) {
        apply(to: cell as! CellType, containerView: containerView)
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
        switch CellType.self {
        case is XibTableViewCell.Type, is XibCollectionViewCell.Type:
            return .xib
        case is CodedTableViewCell.Type, is CodedCollectionViewCell.Type:
            return .code
        default:
            return .storyboard
        }
    }

    func cellType() -> UIView.Type {
        CellType.self
    }

    func register(tableView: UITableView, identifier: String) {
        tableView.register(CellType.self, forCellReuseIdentifier: identifier)
    }

    func height(containerView: UIScrollView) -> CGFloat? {
        nil
    }
    
    var reuseIdentifier: String? { nil }
    
    var bundle: Bundle? { nil }
}
