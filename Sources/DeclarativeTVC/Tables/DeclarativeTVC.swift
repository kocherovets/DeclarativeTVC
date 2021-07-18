//
//  DeclarativeTVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import DifferenceKit
import UIKit

open class DeclarativeTVC: UITableViewController, Table {
    public private(set) var model: TableModel?
    var registeredCells = [String]()
    var registeredHeadersAndFooters = [String]()

    open func set(rows: [CellAnyModel], animations: Animations? = nil, completion: (() -> Void)? = nil) {
        set(model: TableModel(rows: rows), animations: animations, completion: completion)
    }

    open func set(model: TableModel, animations: Animations? = nil, completion: (() -> Void)? = nil) {
        let newModel = model

        if let animations = animations, let model = self.model {
            var cells = [Int: CellAnyModel]()

            let source: [ArraySection<CellDifferentiable, CellDifferentiable>] = model.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.rows.map {
                                 let hash = $0.innerHashValue()
                                 cells[hash] = $0
                                 return CellDifferentiable(hash: hash,
                                                           contentEquatable: $0.innerAnimationEquatableValue())
                             })
            }
            let target: [ArraySection<CellDifferentiable, CellDifferentiable>] = newModel.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.rows.map {
                                 let hash = $0.innerHashValue()
                                 cells[hash] = $0
                                 return CellDifferentiable(hash: hash,
                                                           contentEquatable: $0.innerAnimationEquatableValue())
                             })
            }

            let changeset = StagedChangeset(
                source: source,
                target: target
            )

            self.model = newModel

            if isFirstOption(stagedChangeset: changeset) {
                tableView.customReload(
                    using: changeset,
                    with: animations,
                    setData: { [weak self] in

                        self?.model = newModel
                    },
                    completion: {
                        completion?()
                    }
                )
            } else {
                tableView.customReload2(
                    using: changeset,
                    with: animations,
                    setData: { [weak self] data in

                        var sections = [TableSection]()

                        for newSection in data {
                            var section: TableSection?
                            if let sourceSection = model.sections.first(where: { newSection.model.hash == $0.cellDifferentiable.hash }) {
                                section = sourceSection
                            } else if let sourceSection = newModel.sections.first(where: { newSection.model.hash == $0.cellDifferentiable.hash }) {
                                section = sourceSection
                            }

                            print(newSection.elements.compactMap { $0.hash })
                            print("3-----")

                            sections.append(
                                TableSection(header: section?.header,
                                             rows: newSection.elements.compactMap { cells[$0.hash] },
                                             footer: section?.footer)
                            )
                        }
                        self?.model = TableModel(sections: sections)
                    },
                    completion: {
                        completion?()
                    }
                )
            }
        } else {
            self.model = newModel
            tableView.reloadData()
            completion?()
        }
    }

    func isFirstOption<C>(stagedChangeset: StagedChangeset<C>) -> Bool {
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

        return elementMoved.count == 0
    }

    override open func numberOfSections(in tableView: UITableView) -> Int {
        model?.sections.count ?? 0
    }

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.sections[section].rows.count ?? 0
    }

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell(for: indexPath)
    }

    override open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header(for: section)
    }

    override open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        headerTitle(for: section)
    }

    override open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footer(for: section)
    }

    override open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        footerTitle(for: section)
    }

    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForCell(at: indexPath, containerView: tableView)
    }

    override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        heightForHeader(inSection: section, containerView: tableView)
    }

    override open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        heightForFooter(inSection: section, containerView: tableView)
    }

    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vm = model?.sections[indexPath.section].rows[indexPath.row] as? SelectableCellModel else { return }

        vm.selectCommand.perform()
    }
}
