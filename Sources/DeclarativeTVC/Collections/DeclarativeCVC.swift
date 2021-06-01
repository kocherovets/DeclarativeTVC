//
//  DeclarativeCVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import DifferenceKit
import UIKit

open class DeclarativeCVC: UICollectionViewController, Collection {
    public private(set) var model: CollectionModel?
    var registeredCells = [String]()
    var registeredHeadersAndFooters: [String] = []

    open func set(items: [CollectionCellAnyModel], animated: Bool) {
        set(model: CollectionModel(items: items), animated: animated)
    }

    open func set(model: CollectionModel, animated: Bool, completion: (() -> Void)? = nil) {
        let newModel = model

        if animated, let model = self.model {
            let source: [ArraySection<CellDifferentiable, CellDifferentiable>] = model.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.items.map {
                                 CellDifferentiable(hash: $0.innerHashValue(),
                                                    contentEquatable: $0.innerAnimationEquatableValue())
                             })
            }
            let target: [ArraySection<CellDifferentiable, CellDifferentiable>] = newModel.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.items.map {
                                 CellDifferentiable(hash: $0.innerHashValue(),
                                                    contentEquatable: $0.innerAnimationEquatableValue())
                             })
            }

            let changeset = StagedChangeset(
                source: source,
                target: target
            )

            self.model = newModel

            collectionView.customReload(using: changeset,
                                        interrupt: { $0.changeCount > 100 },
                                        setData: { [weak self] in
                                            self?.model = newModel
                                        },
                                        completion: {
                                            completion?()
                                        })
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

    override open func collectionView(_ collectionView: UICollectionView,
                                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cell(for: indexPath)
    }

    override open func collectionView(_ collectionView: UICollectionView,
                                      viewForSupplementaryElementOfKind kind: String,
                                      at indexPath: IndexPath) -> UICollectionReusableView {
        supplementaryElement(for: indexPath, ofKind: kind)
    }

    override open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vm = model?.sections[indexPath.section].items[indexPath.row] as? SelectableCellModel else { return }

        vm.selectCommand.perform()
    }
}

extension DeclarativeCVC: UICollectionViewDelegateFlowLayout {
    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizeForCell(at: indexPath, containerView: collectionView)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             referenceSizeForHeaderInSection section: Int) -> CGSize {
        sizeHeaderView(inSection: section, containerView: collectionView)
    }
}
