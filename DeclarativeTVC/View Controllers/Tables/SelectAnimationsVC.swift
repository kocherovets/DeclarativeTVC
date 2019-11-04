//
//  SelectAnimationsVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class SelectAnimationsVC: TVC {

    override func data() -> Data {
        var top: [CellAnyModel] = [
            CheckedCellVM(titleText: "None",
                          checked: state.animations == nil && !state.customAnimations,
                          selectCommand: Command {
                              state.animations = nil
                              state.customAnimations = false
                              self.navigationController?.popViewController(animated: true)
                          }),
            CheckedCellVM(titleText: "Fade",
                          checked: state.animations == DeclarativeTVC.fadeAnimations && !state.customAnimations,
                          selectCommand: Command {
                              state.animations = DeclarativeTVC.fadeAnimations
                              state.customAnimations = false
                              self.navigationController?.popViewController(animated: true)
                          }),
            CheckedCellVM(titleText: "Custom",
                          checked: state.customAnimations,
                          selectCommand: Command {
                              state.customAnimations = true
                              state.animations = state.createCustomAnimations()
                              self.reload()
                          })
        ]
        
        if state.customAnimations {
            top = top + [
                AnimationTypeSelectCellVM(titleText: "Delete Sections",
                                          valueText: state.deleteSectionsAnimation.title,
                                          selectCommand: Command {
                                            state.selectedAnimationType = .deleteSectionsAnimation
                                            self.show(SelectAnimationOptionVC.self)
                                          }),
                AnimationTypeSelectCellVM(titleText: "Insert Sections",
                                          valueText: state.insertSectionsAnimation.title,
                                          selectCommand: Command {
                                              state.selectedAnimationType = .insertSectionsAnimation
                                              self.show(SelectAnimationOptionVC.self)
                                          }),
                AnimationTypeSelectCellVM(titleText: "Reload Sections",
                                          valueText: state.reloadSectionsAnimation.title,
                                          selectCommand: Command {
                                              state.selectedAnimationType = .reloadSectionsAnimation
                                              self.show(SelectAnimationOptionVC.self)
                                          }),
                AnimationTypeSelectCellVM(titleText: "Delete Rows",
                                          valueText: state.deleteRowsAnimation.title,
                                          selectCommand: Command {
                                              state.selectedAnimationType = .deleteRowsAnimation
                                              self.show(SelectAnimationOptionVC.self)
                                          }),
                AnimationTypeSelectCellVM(titleText: "Insert Rows",
                                          valueText: state.insertRowsAnimation.title,
                                          selectCommand: Command {
                                              state.selectedAnimationType = .insertRowsAnimation
                                              self.show(SelectAnimationOptionVC.self)
                                          }),
                AnimationTypeSelectCellVM(titleText: "Reload Rows",
                                          valueText: state.reloadRowsAnimation.title,
                                          selectCommand: Command {
                                              state.selectedAnimationType = .reloadRowsAnimation
                                              self.show(SelectAnimationOptionVC.self)
                                          }),
            ]        }

        return .rows(top)
    }
}
