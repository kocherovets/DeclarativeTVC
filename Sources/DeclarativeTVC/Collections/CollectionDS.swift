//
//  CollectionDS.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import DifferenceKit
import UIKit

open class CollectionDS: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, Collection {
    public private(set) var model: CollectionModel?
    var registeredCells = [String]()
    var registeredHeadersAndFooters: [String] = []
    var collectionView: UICollectionView!

    open func set(collectionView: UICollectionView?, items: [CollectionCellAnyModel], animated: Bool) {
        set(collectionView: collectionView, model: CollectionModel(items: items), animated: animated)
    }

    open func set(collectionView: UICollectionView?, model: CollectionModel, animated: Bool) {
        if self.collectionView != collectionView {
            self.collectionView = collectionView
            self.collectionView?.dataSource = self
            self.collectionView?.delegate = self
        }

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

            collectionView?.customReload(using: changeset,
                                         interrupt: { $0.changeCount > 100 },
                                         setData: { [weak self] in
                                             self?.model = newModel
                                         },
                                         completion: {
                                         })

        } else {
            self.model = newModel
            self.collectionView?.reloadData()
        }
    }

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model?.sections.count ?? 0
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.sections[section].items.count ?? 0
    }

    open func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cell(for: indexPath)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             viewForSupplementaryElementOfKind kind: String,
                             at indexPath: IndexPath) -> UICollectionReusableView {
        supplementaryElement(for: indexPath, ofKind: kind)
    }

    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vm = model?.sections[indexPath.section].items[indexPath.row] as? SelectableCellModel else { return }

        vm.selectCommand.perform()
    }
}

extension CollectionDS: UICollectionViewDelegateFlowLayout {
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
