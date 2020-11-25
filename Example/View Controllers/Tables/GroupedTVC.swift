//
//  GroupedTVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 17.11.2020.
//  Copyright © 2020 Dmitry Kocherovets. All rights reserved.
//

import DeclarativeTVC

class GroupedTVC: DeclarativeTVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set(model: TableModel(sections: [
            TableSection(header: TitleWithoutViewTableHeaderModel(title: "Header Title"),
                         rows: [
                            SimpleXibCellVM(titleText: "Paragraph 1 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
                            SimpleXibCellVM(titleText: "Paragraph 2 jsdklf aslfj "),
                            SimpleXibCellVM(titleText: "Paragraph 3 jsdklf aslfj aksldfj askldfsalk fjlaks falksfdaslfj lkasfdjals kfda;ls dflkas fdlkasfasl")
                         ],
                         footer: TitleWithoutViewTableFooterModel(title: "Footer 1")),
            TableSection(header: TitleWithoutViewTableHeaderModel(title: "Header Title 2"),
                         rows: [
                            SimpleXibCellVM(titleText: "Paragraph 1 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
                            SimpleXibCellVM(titleText: "Paragraph 2 jsdklf aslfj "),
                            SimpleXibCellVM(titleText: "Paragraph 3 jsdklf aslfj aksldfj askldfsalk fjlaks falksfdaslfj lkasfdjals kfda;ls dflkas fdlkasfasl")
                         ],
                         footer: nil),
            TableSection(header: TitleWithoutViewTableHeaderModel(title: " "),
                         rows: [
                            SimpleXibCellVM(titleText: "Paragraph 1 jsdklf aslfj lkasfdjals kfda;ls dflkas fdlkasfasl"),
                            SimpleXibCellVM(titleText: "Paragraph 2 jsdklf aslfj "),
                            SimpleXibCellVM(titleText: "Paragraph 3 jsdklf aslfj aksldfj askldfsalk fjlaks falksfdaslfj lkasfdjals kfda;ls dflkas fdlkasfasl")
                         ],
                         footer: TitleWithoutViewTableFooterModel(title: "Footer 3 skldf ksfjkl s dfklsdfjlksdflks kld flksf sklf skdf lksf aldkf alsdfjla sflasf jlas flaksflask jaslf asl;f aslf asl aslkdf aslf lasdfjsalf as;lf alf aslkfjalasfa")),
        ]))
    }
}
