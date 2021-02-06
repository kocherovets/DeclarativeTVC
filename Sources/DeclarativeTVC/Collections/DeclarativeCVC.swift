//
//  DeclarativeCVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import DifferenceKit
import UIKit

open class DeclarativeCVC: UICollectionViewController {
    private var model: CollectionModel?
    private var registeredCells = [String]()

    open func set(items: [CellAnyModel], animated: Bool) {
        set(model: CollectionModel(items: items), animated: animated)
    }

    open func set(model: CollectionModel, animated: Bool) {
        let newModel = model

        if animated, let model = self.model {
            let source: [ArraySection<CellDifferentiable, CellDifferentiable>] = model.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.items.map {
                                 CellDifferentiable(hash: $0.innerHashValue(),
                                                    contentEquatable: $0.innerContentEquatableValue())
                             })
            }
            let target: [ArraySection<CellDifferentiable, CellDifferentiable>] = newModel.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.items.map {
                                 CellDifferentiable(hash: $0.innerHashValue(),
                                                    contentEquatable: $0.innerContentEquatableValue())
                             })
            }

            let changeset = StagedChangeset(
                source: source,
                target: target
            )

            self.model = newModel

            collectionView.reload(using: changeset, interrupt: { $0.changeCount > 100 }) { [weak self] _ in
                self?.model = newModel
            }
        } else {
            self.model = newModel
            collectionView.reloadData()
        }
    }

    override open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model?.sections.count ?? 0
    }

    override open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.sections[section].items.count ?? 0
    }

    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let vm = model?.sections[indexPath.section].items[indexPath.row] else { return UICollectionViewCell() }

        let cell: UICollectionViewCell
        switch vm.cellType() {
        case .storyboard:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: type(of: vm).cellAnyType),
                                                      for: indexPath)
        case .xib:
            let cellTypeString = String(describing: type(of: vm).cellAnyType)
            if registeredCells.firstIndex(where: { $0 == cellTypeString }) == nil {
                let nib = UINib(nibName: cellTypeString, bundle: Bundle(for: type(of: vm).cellAnyType))
                collectionView.register(nib, forCellWithReuseIdentifier: cellTypeString)
                registeredCells.append(cellTypeString)
            }
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTypeString, for: indexPath)
        case .code:
            let cellTypeString = String(describing: type(of: vm).cellAnyType)
            if registeredCells.firstIndex(where: { $0 == cellTypeString }) == nil {
                vm.register(collectionView: collectionView, identifier: cellTypeString)
                registeredCells.append(cellTypeString)
            }
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTypeString, for: indexPath)
        }

        vm.apply(to: cell)

        return cell
    }

    override open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vm = model?.sections[indexPath.section].items[indexPath.row] as? SelectableCellModel else { return }

        vm.selectCommand.perform()
    }
}
