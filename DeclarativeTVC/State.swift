//
//  State.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

struct State {

    enum DetailType {
        case none

        case severalCellTypes
        case tableAnimations
        case tableAnimations2
        case tableSections
        case tableWithSections
        case tableWithSections2
        case tableRowEditing
        case tableRowEditing2
        case tableRowThreeTypes
        case tableManySections

        case simpleCollection
        case simpleCollection2
    }
    var detailType: DetailType = .none

    var animations: DeclarativeTVC.Animations? = nil
    var customAnimations: Bool = false

    var deleteSectionsAnimation: UITableView.RowAnimation = .none
    var insertSectionsAnimation: UITableView.RowAnimation = .none
    var reloadSectionsAnimation: UITableView.RowAnimation = .none
    var deleteRowsAnimation: UITableView.RowAnimation = .none
    var insertRowsAnimation: UITableView.RowAnimation = .none
    var reloadRowsAnimation: UITableView.RowAnimation = .none

    enum SelectedAnimationType {
        case none
        case deleteSectionsAnimation
        case insertSectionsAnimation
        case reloadSectionsAnimation
        case deleteRowsAnimation
        case insertRowsAnimation
        case reloadRowsAnimation
    }
    var selectedAnimationType: SelectedAnimationType = .none
}

var state = State()

extension State {

    var animationsTitle: String {

        guard let animations = animations else {
            return "None"
        }

        switch animations {
        case DeclarativeTVC.fadeAnimations:
            return "Fade"
        default:
            return "Custom"
        }
    }

    func createCustomAnimations() -> DeclarativeTVC.Animations {

        DeclarativeTVC.Animations(
            deleteSectionsAnimation: self.deleteSectionsAnimation,
            insertSectionsAnimation: self.insertSectionsAnimation,
            reloadSectionsAnimation: self.reloadSectionsAnimation,
            deleteRowsAnimation: self.deleteRowsAnimation,
            insertRowsAnimation: self.insertRowsAnimation,
            reloadRowsAnimation: self.reloadRowsAnimation)
    }

    func selectedAnymationTypeValue() -> UITableView.RowAnimation {
        switch selectedAnimationType {
        case .deleteSectionsAnimation: return deleteSectionsAnimation
        case .insertSectionsAnimation: return insertSectionsAnimation
        case .reloadSectionsAnimation: return reloadSectionsAnimation
        case .deleteRowsAnimation: return deleteRowsAnimation
        case .insertRowsAnimation: return insertRowsAnimation
        case .reloadRowsAnimation: return reloadRowsAnimation
        case .none:
            fatalError()
        }
    }

    mutating func setSelectedAnymationTypeValue(_ value: UITableView.RowAnimation) {
        switch selectedAnimationType {
        case .deleteSectionsAnimation: deleteSectionsAnimation = value
        case .insertSectionsAnimation: insertSectionsAnimation = value
        case .reloadSectionsAnimation: reloadSectionsAnimation = value
        case .deleteRowsAnimation: deleteRowsAnimation = value
        case .insertRowsAnimation: insertRowsAnimation = value
        case .reloadRowsAnimation: reloadRowsAnimation = value
        case .none:
            fatalError()
        }

        animations = createCustomAnimations()
    }

}

extension UITableView.RowAnimation {

    var title: String {
        switch self {
        case .fade: return "Fade"
        case .right: return "Right"
        case .left: return "Left"
        case .top: return "Top"
        case .bottom: return "Bottom"
        case .none: return "None"
        case .middle: return "Middle"
        case .automatic: return "Automatic"
            @unknown default:
            fatalError()
        }
    }

    static var allCases: [UITableView.RowAnimation] {
        [
                .fade,
                .right,
                .left,
                .top,
                .bottom,
                .none,
                .middle,
                .automatic
        ]
    }
}
