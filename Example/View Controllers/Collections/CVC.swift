//
//  CVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 03.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class CVC: DeclarativeCVC {
    
    enum Data {
        case items([CellAnyModel])
        case sections([CollectionSection])
    }

    func data() -> Data {
        return .items([])
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
      
        reload()
    }
    
    func reload() {

        switch data() {
        case .items(let items):
            set(items: items, animated: true)
        case .sections(let sections):
            set(model: CollectionModel(sections: sections), animated: true)
        }
    }
}
