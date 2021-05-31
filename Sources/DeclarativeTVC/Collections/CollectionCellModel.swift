//
//  CollectionCellModel.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 31.05.2021.
//

import DifferenceKit
import UIKit

open class StoryboardCollectionViewCell: UICollectionViewCell {
}

open class XibCollectionViewCell: UICollectionViewCell {
}

open class CodedCollectionViewCell: UICollectionViewCell {
}

public protocol CollectionCellAnyModel {
    static var cellAnyType: UIView.Type { get }

    func apply(to cell: UIView, containerView: UIScrollView)

    func innerHashValue() -> Int

    func innerEquatableValue() -> Int

    func innerAnimationEquatableValue() -> Int

    func cellKind() -> CellKind

    func cellType() -> UIView.Type

    func register(collectionView: UICollectionView, identifier: String)

    func size(containerView: UIScrollView) -> CGSize?

    var reuseIdentifier: String? { get }

    var bundle: Bundle? { get }
}

public protocol CollectionCellModel: CollectionCellAnyModel, Hashable, Differentiable {
    associatedtype CellType: UIView

    func apply(to cell: CellType, containerView: UIScrollView)

    func cellKind() -> CellKind

    func cellType() -> UIView.Type
}

public extension CollectionCellModel {
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

    func register(collectionView: UICollectionView, identifier: String) {
        collectionView.register(CellType.self, forCellWithReuseIdentifier: identifier)
    }

    func size(containerView: UIScrollView) -> CGSize? {
        nil
    }

    var reuseIdentifier: String? { nil }

    var bundle: Bundle? { nil }
}
