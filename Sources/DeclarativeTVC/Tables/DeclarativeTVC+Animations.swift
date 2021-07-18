//
//  DeclarativeTVC+Animations.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import DifferenceKit
import UIKit

public extension DeclarativeTVC {
    struct Animations: Equatable {
        let deleteSectionsAnimation: UITableView.RowAnimation
        let insertSectionsAnimation: UITableView.RowAnimation
        let reloadSectionsAnimation: UITableView.RowAnimation
        let deleteRowsAnimation: UITableView.RowAnimation
        let insertRowsAnimation: UITableView.RowAnimation
        let reloadRowsAnimation: UITableView.RowAnimation

        public init(deleteSectionsAnimation: UITableView.RowAnimation,
                    insertSectionsAnimation: UITableView.RowAnimation,
                    reloadSectionsAnimation: UITableView.RowAnimation,
                    deleteRowsAnimation: UITableView.RowAnimation,
                    insertRowsAnimation: UITableView.RowAnimation,
                    reloadRowsAnimation: UITableView.RowAnimation) {
            self.deleteSectionsAnimation = deleteSectionsAnimation
            self.insertSectionsAnimation = insertSectionsAnimation
            self.reloadSectionsAnimation = reloadSectionsAnimation
            self.deleteRowsAnimation = deleteRowsAnimation
            self.insertRowsAnimation = insertRowsAnimation
            self.reloadRowsAnimation = reloadRowsAnimation
        }
    }

    static let fadeAnimations = Animations(deleteSectionsAnimation: .fade,
                                           insertSectionsAnimation: .fade,
                                           reloadSectionsAnimation: .fade,
                                           deleteRowsAnimation: .fade,
                                           insertRowsAnimation: .fade,
                                           reloadRowsAnimation: .fade)
}

extension UITableView {
    public func customReload2<C>(
        using stagedChangeset: StagedChangeset<C>,
        with animations: DeclarativeTVC.Animations,
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
                    deleteSections(IndexSet(changeset.sectionDeleted),
                                   with: animations.deleteSectionsAnimation)
                }

                if !changeset.sectionInserted.isEmpty {
                    insertSections(IndexSet(changeset.sectionInserted),
                                   with: animations.insertSectionsAnimation)
                }

                if !changeset.sectionUpdated.isEmpty {
                    reloadSections(IndexSet(changeset.sectionUpdated),
                                   with: animations.reloadSectionsAnimation)
                }

                for (source, target) in changeset.sectionMoved {
                    moveSection(source, toSection: target)
                }

                if !changeset.elementDeleted.isEmpty {
                    deleteRows(at: changeset.elementDeleted.map { IndexPath(item: $0.element, section: $0.section) },
                               with: animations.deleteRowsAnimation)
                }

                if !changeset.elementInserted.isEmpty {
                    insertRows(at: changeset.elementInserted.map { IndexPath(item: $0.element, section: $0.section) },
                               with: animations.insertRowsAnimation)
                }

                if !changeset.elementUpdated.isEmpty {
                    reloadRows(at: changeset.elementUpdated.map { IndexPath(item: $0.element, section: $0.section) },
                               with: animations.reloadRowsAnimation)
                }

                for (source, target) in changeset.elementMoved {
                    moveRow(at: IndexPath(item: source.element, section: source.section),
                            to: IndexPath(item: target.element, section: target.section))
                }

            }) { _ in
                completion?()
            }
        }
    }

    public func customReload<C>(
        using stagedChangeset: StagedChangeset<C>,
        with animations: DeclarativeTVC.Animations,
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
                    deleteSections(IndexSet(sectionDeleted),
                                   with: animations.deleteSectionsAnimation)
                }

                if !sectionInserted.isEmpty {
                    insertSections(IndexSet(sectionInserted),
                                   with: animations.insertSectionsAnimation)
                }

                if !sectionUpdated.isEmpty {
                    reloadSections(IndexSet(sectionUpdated),
                                   with: animations.reloadSectionsAnimation)
                }

                for (source, target) in sectionMoved {
                    moveSection(source, toSection: target)
                }

                if !elementDeleted.isEmpty {
                    deleteRows(at: elementDeleted.map { IndexPath(row: $0.element, section: $0.section) },
                               with: animations.deleteRowsAnimation)
                }

                if !elementInserted.isEmpty {
                    insertRows(at: elementInserted.map { IndexPath(row: $0.element, section: $0.section) },
                               with: animations.insertRowsAnimation)
                }

                if !elementUpdated.isEmpty {
                    reloadRows(at: elementUpdated.map { IndexPath(row: $0.element, section: $0.section) },
                               with: animations.reloadRowsAnimation)
                }

                for (source, target) in elementMoved {
                    moveRow(at: IndexPath(row: source.element, section: source.section),
                            to: IndexPath(row: target.element, section: target.section))
                }
            },
            completion: { _ in
                completion?()
            })
    }
}
