//
//  CollectionHeaderAnyModel.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 31.05.2021.
//

import UIKit

open class XibCollectionHeaderFooterView: UICollectionReusableView {
}

open class CodedCollectionHeaderFooterView: UICollectionReusableView {
}

public protocol CollectionHeaderAnyModel {
    
    static var headerAnyType: UIView.Type { get }
    
    func apply(to header: UIView, containerView: UIScrollView)
    
    func innerHashValue() -> Int
    
    func innerEquatableValue() -> Int

    func innerAnimationEquatableValue() -> Int

    func cellKind() -> CellKind
    
    func register(collectionView: UICollectionView, kind: String, identifier: String)

    func size(containerView: UIScrollView) -> CGSize?

    var reuseIdentifier: String? { get }
    
    var bundle: Bundle? { get }
}

public protocol CollectionHeaderModel: CollectionHeaderAnyModel, Hashable {
    
    associatedtype HeaderType: UIView
    
    func apply(to header: HeaderType, containerView: UIScrollView)
    
    func cellKind() -> CellKind
}

public extension CollectionHeaderModel {
    
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
        case is XibCollectionHeaderFooterView.Type:
            return .xib
        case is CodedCollectionHeaderFooterView.Type:
            return .code
        default:
            return .storyboard
        }
    }
        
    func register(collectionView: UICollectionView, kind: String, identifier: String) {
        collectionView.register(HeaderType.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }

    func size(containerView: UIScrollView) -> CGSize? {
        nil
    }
    
    var reuseIdentifier: String? { nil }
    
    var bundle: Bundle? { nil }
}
