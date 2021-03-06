//
//  TableDS.swift
//  Framework
//
//  Created by Dmitry Kocherovets on 01.01.2020.
//  Copyright © 2020 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DifferenceKit

open class TableDS: NSObject, UITableViewDelegate, UITableViewDataSource, Table {

    public private(set) var model: TableModel? = nil
    var registeredCells = [String]()
    var registeredHeadersAndFooters = [String]()
    var tableView: UITableView!

    open func set(tableView: UITableView?,
                  rows: [CellAnyModel],
                  animations: DeclarativeTVC.Animations? = nil,
                  completion: (() -> Void)? = nil) {

        set(tableView: tableView, model: TableModel(rows: rows), animations: animations, completion: completion)
    }

    open func set(tableView: UITableView?,
                  model: TableModel,
                  animations: DeclarativeTVC.Animations? = nil,
                  completion: (() -> Void)? = nil) {

        if self.tableView != tableView {
            self.tableView = tableView
            self.tableView?.dataSource = self
            self.tableView?.delegate = self
        }

        let newModel = model

        if let animations = animations, let model = self.model {

            let source: [ArraySection<CellDifferentiable, CellDifferentiable>] = model.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.rows.map {
                                 CellDifferentiable(hash: $0.innerHashValue(),
                                                    contentEquatable: $0.innerAnimationEquatableValue())
                             })
            }
            let target: [ArraySection<CellDifferentiable, CellDifferentiable>] = newModel.sections.map { section in
                ArraySection(model: section.cellDifferentiable,
                             elements: section.rows.map {
                                 CellDifferentiable(hash: $0.innerHashValue(),
                                                    contentEquatable: $0.innerAnimationEquatableValue())
                             })
            }

            let changeset = StagedChangeset(
                source: source,
                target: target
            )

            self.model = newModel

            tableView?.customReload(
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
            tableView?.reloadData()
            completion?()
        }
    }

    open func numberOfSections(in tableView: UITableView) -> Int {
        model?.sections.count ?? 0
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.sections[section].rows.count ?? 0
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell(for: indexPath)
    }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header(for: section)
    }

    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        headerTitle(for: section)
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footer(for: section)
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        footerTitle(for: section)
    }

    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForCell(at: indexPath, containerView: tableView)
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        heightForHeader(inSection: section, containerView: tableView)
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        heightForFooter(inSection: section, containerView: tableView)
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let vm = model?.sections[indexPath.section].rows[indexPath.row] as? SelectableCellModel else { return }

        vm.selectCommand.perform()
    }
}
