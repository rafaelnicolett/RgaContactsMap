//
//  ModalContainerViewController.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 29/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import UIKit

class ModalContainerViewController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(done(_:)))
        topViewController?.navigationItem.rightBarButtonItem = doneItem
        
        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(done(_:)))
        topViewController?.navigationItem.rightBarButtonItem = deleteItem
    }
    
    @objc private func done(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
}
