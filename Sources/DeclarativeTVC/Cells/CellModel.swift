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

open class StoryboardCollectionViewCell: UICollectionViewCell {
}

open class XibCollectionViewCell: UICollectionViewCell {
}

open class CodedCollectionViewCell: UICollectionViewCell {
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

    func cellType() -> CellKind

    func register(tableView: UITableView, identifier: String)

    func register(collectionView: UICollectionView, identifier: String)

    func height(containerView: UIScrollView) -> CGFloat?
    
    var reuseIdentifier: String? { get }

    var bundle: Bundle? { get }
}

public protocol CellModel: CellAnyModel, Hashable, Differentiable {
    associatedtype CellType: UIView

    func apply(to cell: CellType, containerView: UIScrollView)

    func cellType() -> CellKind
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

    func cellType() -> CellKind {
        switch CellType.self {
        case is XibTableViewCell.Type, is XibCollectionViewCell.Type:
            return .xib
        case is CodedTableViewCell.Type, is CodedCollectionViewCell.Type:
            return .code
        default:
            return .storyboard
        }
    }

    func register(tableView: UITableView, identifier: String) {
        tableView.register(CellType.self, forCellReuseIdentifier: identifier)
    }

    func register(collectionView: UICollectionView, identifier: String) {
        collectionView.register(CellType.self, forCellWithReuseIdentifier: identifier)
    }

    func height(containerView: UIScrollView) -> CGFloat? {
        nil
    }
    
    var reuseIdentifier: String? { nil }
    
    var bundle: Bundle? { nil }
}
