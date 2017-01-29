//
//  UITableView+Diff.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 29/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import UIKit
import IGListKit

extension UITableView {
    func reload(oldData: [IGListDiffable], newData: [IGListDiffable]) {
        let diff = IGListDiffPaths(0, 0, oldData, newData, .equality)
        
        beginUpdates()
        insertRows(at: diff.inserts, with: .top)
        deleteRows(at: diff.deletes, with: .bottom)
        reloadRows(at: diff.updates, with: .none)
        endUpdates()
    }
}
