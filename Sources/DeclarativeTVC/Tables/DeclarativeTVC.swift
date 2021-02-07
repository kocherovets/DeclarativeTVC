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

    open func set(rows: [CellAnyModel], animations: Animations? = nil, completion: (() -> Void)? = nil) {
        set(model: TableModel(rows: rows), animations: animations, completion: completion)
    }

    open func set(model: TableModel, animations: Animations? = nil, completion: (() -> Void)? = nil) {
        let newModel = model

        if let animations = animations, let model = self.model {
            let source: [ArraySection<CellDifferentiable, CellDifferentiable>] = model.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.rows.map {
                                 CellDifferentiable(hash: $0.innerHashValue(),
                                                    contentEquatable: $0.innerContentEquatableValue())
                             })
            }
            let target: [ArraySection<CellDifferentiable, CellDifferentiable>] = newModel.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.rows.map {
                                 CellDifferentiable(hash: $0.innerHashValue(),
                                                    contentEquatable: $0.innerContentEquatableValue())
                             })
            }

            let changeset = StagedChangeset(
                source: source,
                target: target
            )

            self.model = newModel
            
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
            self.model = newModel
            tableView.reloadData()
            completion?()
        }
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
        heightForCell(at: indexPath)
    }

    override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        heightForHeader(inSection: section)
    }

    override open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        heightForFooter(inSection: section)
    }

    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vm = model?.sections[indexPath.section].rows[indexPath.row] as? SelectableCellModel else { return }

        vm.selectCommand.perform()
    }
}
