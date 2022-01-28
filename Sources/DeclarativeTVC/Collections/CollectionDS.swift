//
//  CollectionDS.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import DifferenceKit
import UIKit

 extension StagedChangeset {
    // DifferenceKit splits different type of actions into the different change sets to avoid the limitations of UICollectionView
    // But it may lead to the situations that `UICollectionViewLayout` doesnt know what change will happen next within the single portion
    // of changes. As we know that at least insertions and deletions can be processed together, we fix that in the StagedChangeset we got from
    // DifferenceKit.
    func flattenIfPossible() -> StagedChangeset {
        if count == 2,
           self[0].sectionChangeCount == 0,
           self[1].sectionChangeCount == 0,
           self[0].elementDeleted.count == self[0].elementChangeCount,
           self[1].elementInserted.count == self[1].elementChangeCount {
            return StagedChangeset(arrayLiteral: Changeset(data: self[1].data, elementDeleted: self[0].elementDeleted, elementInserted: self[1].elementInserted))
        }
        return self
    }
 }

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
            var cells = [Int: CollectionCellAnyModel]()

            let source: [ArraySection<CellDifferentiable, CellDifferentiable>] = model.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.items.map {
                                 let hash = $0.innerHashValue()
                                 cells[hash] = $0
                                 return CellDifferentiable(hash: hash,
                                                           contentEquatable: $0.innerAnimationEquatableValue())
                             })
            }
            let target: [ArraySection<CellDifferentiable, CellDifferentiable>] = newModel.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.items.map {
                                 let hash = $0.innerHashValue()
                                 cells[hash] = $0
                                 return CellDifferentiable(hash: hash,
                                                           contentEquatable: $0.innerAnimationEquatableValue())
                             })
            }

            let changeset = StagedChangeset(
                source: source,
                target: target
            ) // .flattenIfPossible()

            collectionView?.customReload2(
                using: changeset,
                interrupt: { $0.changeCount > 100 },
                setData: { [weak self] data in

                    var sections = [CollectionSection]()

                    for newSection in data {
                        var section: CollectionSection?
                        if let sourceSection = model.sections.first(where: { newSection.model.hash == $0.cellDifferentiable.hash }) {
                            section = sourceSection
                        } else if let sourceSection = newModel.sections.first(where: { newSection.model.hash == $0.cellDifferentiable.hash }) {
                            section = sourceSection
                        }

                        sections.append(
                            CollectionSection(header: section?.header,
                                              items: newSection.elements.compactMap { cells[$0.hash] },
                                              footer: section?.footer)
                        )
                    }
                    self?.model = CollectionModel(sections: sections)
                }, completion: {
                })

        } else {
            self.model = newModel
            self.collectionView?.reloadData()
            self.collectionView?.reloadData() // do not delete
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
