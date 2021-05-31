//
//  CollectionFooterModel.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 31.05.2021.
//

import UIKit

public protocol CollectionFooterAnyModel {
    
    static var footerAnyType: UIView.Type { get }
    
    func apply(to footer: UIView, containerView: UIScrollView)
    
    func innerHashValue() -> Int
    
    func innerEquatableValue() -> Int

    func innerAnimationEquatableValue() -> Int

    func cellKind() -> CellKind
    
    func register(collectionView: UICollectionView, kind: String, identifier: String)

    func size(containerView: UIScrollView) -> CGSize?

    var reuseIdentifier: String? { get }
    
    var bundle: Bundle? { get }
}

public protocol CollectionFooterModel: CollectionFooterAnyModel, Hashable {
    
    associatedtype FooterType: UIView
    
    func apply(to footer: FooterType, containerView: UIScrollView)
    
    func cellKind() -> CellKind
}

public extension CollectionFooterModel {
    
    static var footerAnyType: UIView.Type {
        return FooterType.self
    }
    
    func apply(to footer: UIView, containerView: UIScrollView) {
        apply(to: footer as! FooterType, containerView: containerView)
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
        switch FooterType.self {
        case is XibCollectionHeaderFooterView.Type:
            return .xib
        case is CodedCollectionHeaderFooterView.Type:
            return .code
        default:
            return .storyboard
        }
    }
        
    func register(collectionView: UICollectionView, kind: String, identifier: String) {
        collectionView.register(FooterType.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }

    func size(containerView: UIScrollView) -> CGSize? {
        nil
    }
    
    var reuseIdentifier: String? { nil }
    
    var bundle: Bundle? { nil }
}
