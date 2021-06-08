//
//  UICollectionView+.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 31.05.2021.
//

import UIKit

protocol Collection: AnyObject {
    var model: CollectionModel? { get }
    var registeredCells: [String] { get set }
    var registeredHeadersAndFooters: [String] { get set }
    var collectionView: UICollectionView! { get }
}

extension Collection {
    func cell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let vm = model?.sections[indexPath.section].items[indexPath.row] else { return UICollectionViewCell() }

        let cellTypeString = vm.reuseIdentifier ?? String(describing: type(of: vm).cellAnyType)
        let cell: UICollectionViewCell
        switch vm.cellKind() {
        case .storyboard:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTypeString, for: indexPath)
        case .xib:
            if registeredCells.firstIndex(where: { $0 == cellTypeString }) == nil {
                let nib = UINib(nibName: cellTypeString, bundle: Bundle(for: type(of: vm).cellAnyType))
                collectionView.register(nib, forCellWithReuseIdentifier: cellTypeString)
                registeredCells.append(cellTypeString)
            }
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTypeString, for: indexPath)
        case .code:
            if registeredCells.firstIndex(where: { $0 == cellTypeString }) == nil {
                vm.register(collectionView: collectionView, identifier: cellTypeString)
                registeredCells.append(cellTypeString)
            }
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTypeString, for: indexPath)
        }

        vm.apply(to: cell, containerView: collectionView)

        return cell
    }

    func supplementaryElement(for indexPath: IndexPath, ofKind kind: String) -> UICollectionReusableView {
        guard let vm = model?.sections[indexPath.section].header else {
            return UICollectionReusableView()
        }

        let typeString = vm.reuseIdentifier ?? String(describing: type(of: vm).headerAnyType)
        let cell: UICollectionReusableView
        switch vm.cellKind() {
        case .storyboard:
            cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: typeString,
                                                                   for: indexPath)
        case .xib:
            if registeredCells.firstIndex(where: { $0 == typeString }) == nil {
                let nib = UINib(nibName: typeString, bundle: Bundle(for: type(of: vm).headerAnyType))
                collectionView.register(nib,
                                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: typeString)
                registeredCells.append(typeString)
            }
            cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: typeString,
                                                                   for: indexPath)
        case .code:
            if registeredCells.firstIndex(where: { $0 == typeString }) == nil {
                vm.register(collectionView: collectionView, kind: kind, identifier: typeString)
                registeredCells.append(typeString)
            }
            cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: typeString,
                                                                   for: indexPath)
        }

        vm.apply(to: cell, containerView: collectionView)

        return cell
    }

    func sizeForCell(at indexPath: IndexPath, containerView: UIScrollView) -> CGSize {
        guard let model = model,
              model.sections.count > indexPath.section,
              model.sections[indexPath.section].items.count > indexPath.item
        else {
            return .zero
        }
        if let size = model.sections[indexPath.section].items[indexPath.item].size(containerView: collectionView) {
            return size
        }
        return UICollectionViewFlowLayout.automaticSize
    }

    func sizeHeaderView(inSection section: Int, containerView: UIScrollView) -> CGSize {
        guard let model = model, model.sections.count > section else { return .zero }
        if let size = model.sections[section].header?.size(containerView: collectionView) {
            return size
        }
        return .zero
    }

    func sizeFooterView(inSection section: Int, containerView: UIScrollView) -> CGSize {
        if let size = model?.sections[section].footer?.size(containerView: collectionView) {
            return size
        }
        return .zero
    }
}
