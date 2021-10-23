//
//  DeclarativeCVC+Animations.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 01.06.2021.
//

import DifferenceKit
import UIKit

extension UICollectionView {
    public func customReload2<C>(
        using stagedChangeset: StagedChangeset<C>,
        interrupt: ((Changeset<C>) -> Bool)? = nil,
        setData: (C) -> Void,
        completion: (() -> Void)? = nil
    ) {
        for changeset in stagedChangeset {
            if let interrupt = interrupt, interrupt(changeset), let data = stagedChangeset.last?.data {
                setData(data)
                return reloadData()
            }

            performBatchUpdates({
                setData(changeset.data)

                if !changeset.sectionDeleted.isEmpty {
                    deleteSections(IndexSet(changeset.sectionDeleted))
                }

                if !changeset.sectionInserted.isEmpty {
                    insertSections(IndexSet(changeset.sectionInserted))
                }

                if !changeset.sectionUpdated.isEmpty {
                    reloadSections(IndexSet(changeset.sectionUpdated))
                }

                for (source, target) in changeset.sectionMoved {
                    moveSection(source, toSection: target)
                }

                if !changeset.elementDeleted.isEmpty {
                    deleteItems(at: changeset.elementDeleted.map { IndexPath(item: $0.element, section: $0.section) })
                }

                if !changeset.elementInserted.isEmpty {
                    insertItems(at: changeset.elementInserted.map { IndexPath(item: $0.element, section: $0.section) })
                }

                if !changeset.elementUpdated.isEmpty {
                    reloadItems(at: changeset.elementUpdated.map { IndexPath(item: $0.element, section: $0.section) })
                }

                for (source, target) in changeset.elementMoved {
                    moveItem(at: IndexPath(item: source.element, section: source.section), to: IndexPath(item: target.element, section: target.section))
                }

//                if stagedChangeset.count == 1 {
//                    collectionViewLayout.invalidateLayout()
//                    layoutIfNeeded()
//                }

            }) { _ in
                completion?()
            }
        }
    }

    public func customReload<C>(
        using stagedChangeset: StagedChangeset<C>,
        interrupt: ((Changeset<C>) -> Bool)? = nil,
        setData: () -> Void,
        completion: (() -> Void)? = nil
    ) {
        var sectionDeleted = [Int]()
        var sectionInserted = [Int]()
        var sectionUpdated = [Int]()
        var sectionMoved = [(source: Int, target: Int)]()

        var elementDeleted = [ElementPath]()
        var elementInserted = [ElementPath]()
        var elementUpdated = [ElementPath]()
        var elementMoved = [(source: ElementPath, target: ElementPath)]()

        for changeset in stagedChangeset {
            sectionDeleted.append(contentsOf: changeset.sectionDeleted)
            sectionInserted.append(contentsOf: changeset.sectionInserted)
            sectionUpdated.append(contentsOf: changeset.sectionUpdated)
            sectionMoved.append(contentsOf: changeset.sectionMoved)

            elementDeleted.append(contentsOf: changeset.elementDeleted)
            elementInserted.append(contentsOf: changeset.elementInserted)
            elementUpdated.append(contentsOf: changeset.elementUpdated)
            elementMoved.append(contentsOf: changeset.elementMoved)
        }

        performBatchUpdates(
            {
                setData()

                if !sectionDeleted.isEmpty {
                    deleteSections(IndexSet(sectionDeleted))
                }

                if !sectionInserted.isEmpty {
                    insertSections(IndexSet(sectionInserted))
                }

                if !sectionUpdated.isEmpty {
                    reloadSections(IndexSet(sectionUpdated))
                }

                for (source, target) in sectionMoved {
                    moveSection(source, toSection: target)
                }

                if !elementDeleted.isEmpty {
                    deleteItems(at: elementDeleted.map { IndexPath(item: $0.element, section: $0.section) })
                }

                if !elementInserted.isEmpty {
                    insertItems(at: elementInserted.map { IndexPath(item: $0.element, section: $0.section) })
                }

                if !elementUpdated.isEmpty {
                    reloadItems(at: elementUpdated.map { IndexPath(item: $0.element, section: $0.section) })
                }

                for (source, target) in elementMoved {
                    moveItem(at: IndexPath(item: source.element, section: source.section),
                             to: IndexPath(item: target.element, section: target.section))
                }

                collectionViewLayout.invalidateLayout()
                layoutIfNeeded()

            },
            completion: { _ in
                completion?()
            })
    }
}
