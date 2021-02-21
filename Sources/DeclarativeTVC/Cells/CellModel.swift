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
    case notCell
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

    func apply(to cell: UIView)

    func innerHashValue() -> Int

    func innerEquatableValue() -> Int

    func innerRowAnimationEquatableValue() -> Int

    func cellType() -> CellKind

    func register(tableView: UITableView, identifier: String)

    func register(collectionView: UICollectionView, identifier: String)

    func height(tableFrame: CGRect) -> CGFloat?
}

public protocol CellModel: CellAnyModel, Hashable, Differentiable {
    associatedtype CellType: UIView

    func apply(to cell: CellType)

    func cellType() -> CellKind
}

public extension CellModel {
    static var cellAnyType: UIView.Type {
        return CellType.self
    }

    func apply(to cell: UIView) {
        apply(to: cell as! CellType)
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
        switch CellType.self {
        case is XibTableViewCell.Type, is XibCollectionViewCell.Type:
            return .xib
        case is CodedTableViewCell.Type, is CodedCollectionViewCell.Type:
            return .code
        case is UITableViewCell.Type, is StoryboardTableViewCell.Type, is UICollectionViewCell.Type, is StoryboardCollectionViewCell.Type:
            return .storyboard
        default:
            return .notCell
        }
    }

    func register(tableView: UITableView, identifier: String) {
        tableView.register(CellType.self, forCellReuseIdentifier: identifier)
    }

    func register(collectionView: UICollectionView, identifier: String) {
        collectionView.register(CellType.self, forCellWithReuseIdentifier: identifier)
    }

    func height(tableFrame: CGRect) -> CGFloat? {
        nil
    }
}
