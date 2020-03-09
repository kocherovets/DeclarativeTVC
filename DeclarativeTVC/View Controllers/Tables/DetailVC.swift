//
//  DetailVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit

class DetailVC: TVC {

    override func data() -> Data {

        switch state.detailType {
        case .severalCellTypes:
            return .rows(severalCellTypesRows())
        case .tableAnimations:
            return .rows(tableAnimationsRows())
        case .tableAnimations2:
            return .rows(tableAnimations2Rows())
        case .tableSections:
            return .sections(tableSections())
        case .tableWithSections:
            return .sections(tableWithSections())
        case .tableWithSections2:
            return .sections(tableWithSections2())
        case .tableRowEditing:
            return .rows(tableRowEditing())
        case .tableRowEditing2:
            return .rows(tableRowEditing2())
        case .tableRowThreeTypes:
            return .rows(tableRowThreeTypes())
        case .tableManySections:
            return .sections(tableManySections())
        default:
            return .rows([])
        }
    }

    override func animations() -> DeclarativeTVC.Animations? {
        return state.animations
    }
}

//MARK: Example: Several table cell types

extension DetailVC {

    private func severalCellTypesRows() -> [CellAnyModel] {
        [
            HeaderCellVM(titleText: "Header 1"),
            SimpleXibCellVM(titleText: "Paragraph 111 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
            SimpleCellVM(titleText: "Paragraph 2 jsdklf aslfj "),
            SimpleCellVM(titleText: "Paragraph 3 jsdklf aslfj aksldfj askldfsalk fjlaks falksfdaslfj lkasfdjals kfda;ls dflkas fdlkasfasl")
        ]
    }
}

//MARK: Example: Table Animations

extension DetailVC {

    private func tableAnimationsRows() -> [CellAnyModel] {
        [
            SelectAnimationsCellVM(titleText: "Select animations",
                                   animationText: state.animationsTitle,
                                   selectCommand: Command { [weak self] in
                                    self?.show(SelectAnimationsVC.self)
                                   }),
            ApplyAnimationsCellVM(titleText: "Apply animations",
                                  selectCommand: Command {[weak self] in
                                      state.detailType = .tableAnimations2
                                    self?.reload()
                                  }),
            HeaderCellVM(titleText: "Header 1"),
            SimpleCellVM(titleText: "Paragraph 11 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
            SimpleCellVM(titleText: "Paragraph 12 jsdklf aslfj "),
            SimpleCellVM(titleText: "Paragraph 13 jsdklf aslfj aksldfj askldfsalk fjlaks falksfdaslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
            HeaderCellVM(titleText: "Header 2"),
            SimpleCellVM(titleText: "Paragraph 21 sdfj laksdjf aklsfaskld"),
            SimpleCellVM(titleText: "Paragraph 22 ksdf sajdf laksflsjlksjd lkaf safjsalkfsf"),
            SimpleCellVM(titleText: "Paragraph 23 sd fksf sdflsaklfj lksakl aslkdf alsfa")
        ]
    }

    private func tableAnimations2Rows() -> [CellAnyModel] {
        [
            ApplyAnimationsCellVM(titleText: "Reset rows",
                                  selectCommand: Command {[weak self] in
                                      state.detailType = .tableAnimations
                                    self?.reload()
                                  }),
            HeaderCellVM(titleText: "Header 1"),
            SimpleCellVM(titleText: "Paragraph 11 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
            HeaderCellVM(titleText: "Header 2"),
            SimpleCellVM(titleText: "Paragraph 21 sdfj laksdjf aklsfaskld"),
            SimpleCellVM(titleText: "Paragraph 211 jsa dfkl askdlfasdf sdf asdf sf asf"),
            SimpleCellVM(titleText: "Paragraph 22 ksdf sajdf laksflsjlksjd lkaf safjsalkfsf"),
            SimpleCellVM(titleText: "Paragraph 23 sd fksf sdflsaklfj lksakl aslkdf alsfa")
        ]
    }
}

//MARK: Example: Table Sections

extension DetailVC {

    private func tableSections() -> [TableSection] {
        [
            TableSection(header: HeaderViewVM(titleText: "Section header"),
                         rows: [
                             SimpleCellVM(titleText: "Paragraph 1 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
                             SimpleCellVM(titleText: "Paragraph 2 jsdklf aslfj "),
                             SimpleCellVM(titleText: "Paragraph 3 jsdklf aslfj aksldfj askldfsalk fjlaks falksfdaslfj lkasfdjals kfda;ls dflkas fdlkasfasl")
                         ],
                         footer: nil),
            TableSection(header: HeaderViewVM(titleText: "Section header 2"),
                         rows: [
                             SimpleCellVM(titleText: "Paragraph 1 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
                             SimpleCellVM(titleText: "Paragraph 2 jsdklf aslfj "),
                             SimpleCellVM(titleText: "Paragraph 3 jsdklf aslfj aksldfj askldfsalk fjlaks falksfdaslfj lkasfdjals kfda;ls dflkas fdlkasfasl")
                         ],
                         footer: nil)
        ]
    }
}

//MARK: Example: Table Sections Animations

extension DetailVC {

    private func tableWithSections() -> [TableSection] {
        [
            TableSection(
                header: nil,
                rows: [
                    SelectAnimationsCellVM(
                        titleText: "Select animations",
                        animationText: state.animationsTitle,
                        selectCommand: Command { [weak self] in
                            self?.show(SelectAnimationsVC.self)
                        }),
                    ApplyAnimationsCellVM(
                        titleText: "Apply animations",
                        selectCommand: Command { [weak self] in
                            state.detailType = .tableWithSections2
                            self?.reload()
                        })
                ],
                footer: nil),
            TableSection(
                header: HeaderViewVM(titleText: "Header 1"),
                rows: [
                    SimpleCellVM(titleText: "Paragraph 11 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
                    SimpleCellVM(titleText: "Paragraph 12 jsdklf aslfj "),
                    SimpleCellVM(titleText: "Paragraph 13 jsdklf aslfj aksldfj askldfsalk fjlaks falksfdaslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
                ],
                footer: nil),
            TableSection(
                header: HeaderViewVM(titleText: "Header 2"),
                rows: [
                    SimpleCellVM(titleText: "Paragraph 21 sdfj laksdjf aklsfaskld"),
                    SimpleCellVM(titleText: "Paragraph 22 ksdf sajdf laksflsjlksjd lkaf safjsalkfsf"),
                    SimpleCellVM(titleText: "Paragraph 23 sd fksf sdflsaklfj lksakl aslkdf alsfa")
                ],
                footer: nil),
        ]
    }

    private func tableWithSections2() -> [TableSection] {
        [
            TableSection(header: nil,
                         rows: [
                             ApplyAnimationsCellVM(titleText: "Reset rows",
                                                   selectCommand: Command { [weak self] in
                                                       state.detailType = .tableWithSections
                                                       self?.reload()
                                                   })
                         ],
                         footer: nil),
            TableSection(header: HeaderViewVM(titleText: "Header 1"),
                         rows: [
                             SimpleCellVM(titleText: "Paragraph 11 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
                         ],
                         footer: nil),
            TableSection(header: HeaderViewVM(titleText: "Header 2"),
                         rows: [
                             SimpleCellVM(titleText: "Paragraph 21 sdfj laksdjf aklsfaskld"),
                             SimpleCellVM(titleText: "Paragraph 211 jsa dfkl askdlfasdf sdf asdf sf asf"),
                             SimpleCellVM(titleText: "Paragraph 22 ksdf sajdf laksflsjlksjd lkaf safjsalkfsf"),
                             SimpleCellVM(titleText: "Paragraph 23 sd fksf sdflsaklfj lksakl aslkdf alsfa")
                         ],
                         footer: nil),
        ]
    }
}

//MARK: Example: Table row editing

extension DetailVC {

    private func tableRowEditing() -> [CellAnyModel] {
        [
            SelectAnimationsCellVM(titleText: "Select animations",
                                   animationText: state.animationsTitle,
                                   selectCommand: Command {[weak self] in
                                    self?.show(SelectAnimationsVC.self)
                                   }),
            ApplyAnimationsCellVM(titleText: "Apply animations",
                                  selectCommand: Command {[weak self] in
                                      state.detailType = .tableRowEditing2
                                    self?.reload()
                                  }),
            HeaderCellVM(titleText: "Text field does not lose focus while table reorder with setted animation"),
            TextFieldCellVM(text: nil, placeholder: "text field 1"),
            SimpleCellVM(titleText: "Paragraph 11 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
            SimpleCellVM(titleText: "Paragraph 12 jsdklf aslfj "),
            SimpleCellVM(titleText: "Paragraph 13 jsdklf aslfj aksldfj askldfsalk fjlaks falksfdaslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
            HeaderCellVM(titleText: "Header 2"),
            SimpleCellVM(titleText: "Paragraph 21 sdfj laksdjf aklsfaskld"),
            SimpleCellVM(titleText: "Paragraph 22 ksdf sajdf laksflsjlksjd lkaf safjsalkfsf"),
            TextFieldCellVM(text: nil, placeholder: "text field 2")
        ]
    }

    private func tableRowEditing2() -> [CellAnyModel] {
        [
            ApplyAnimationsCellVM(titleText: "Reset rows",
                                  selectCommand: Command {[weak self] in
                                      state.detailType = .tableRowEditing
                                    self?.reload()
                                  }),
            HeaderCellVM(titleText: "Text field does not lose focus while table reorder with setted animation"),
            TextFieldCellVM(text: nil, placeholder: "text field 1"),
            HeaderCellVM(titleText: "Header 2"),
            SimpleCellVM(titleText: "Paragraph 21 sdfj laksdjf aklsfaskld"),
            SimpleCellVM(titleText: "Paragraph 22 ksdf sajdf laksflsjlksjd lkaf safjsalkfsf"),
            SimpleCellVM(titleText: "Paragraph 23 ksdf sajdf laksflsjlksjd lkaf safjsalkfsf"),
            TextFieldCellVM(text: nil, placeholder: "text field 2"),
            SimpleCellVM(titleText: "Paragraph 24 ksdf sajdf laksflsjlksjd lkaf safjsalkfsf"),
        ]
    }
}

//MARK: Example: Storyboard, xib and code rows

extension DetailVC {

    private func tableRowThreeTypes() -> [CellAnyModel] {
        [
            SimpleCellVM(titleText: "Storyboard cell"),
            SimpleXibCellVM(titleText: "Xib cell"),
            SimpleCodeCellVM(titleText: "Codeв cell. All table cells in this app use autolayout to calculate their heights. But this coded cell uses hardcoded height 200.")
        ]
    }
}


//

extension DetailVC {

    private func tableManySections() -> [TableSection] {

        var result = [TableSection]()

        for i in 0 ..< 100 {
            result.append(
                TableSection(
                    header: HeaderViewVM(titleText: "Header \(i)"),
                    rows: [
                        SimpleCellVM(titleText: "\(i)")
                    ],
                    footer: FooterViewVM(
                        titleText: "Footer \(i)",
                        h: CGFloat(60 + i)
                    )
                )
            )
        }

        return result
    }
}
