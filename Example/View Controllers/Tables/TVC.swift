//
//  TVC.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import UIKit
import DeclarativeTVC

class TVC: UIViewController {
    
    enum Data {
        case rows([CellAnyModel])
        case sections([TableSection])
    }

    private var tvc: DeclarativeTVC? = nil

    func data() -> Data {
        return .rows([])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let vc = segue.destination as? DeclarativeTVC {
            tvc = vc
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
      
        reload()
    }
    
    func reload() {

        switch data() {
        case .rows(let rows):
            tvc?.set(rows: rows, animations: animations())
        case .sections(let sections):
            tvc?.set(model: TableModel(sections: sections), animations: animations())
        }
    }
    
    func animations() -> DeclarativeTVC.Animations? {
        return nil
    }

    func show<T: UIViewController>(_ type: T.Type) {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: String(describing: T.self)) as! T
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
