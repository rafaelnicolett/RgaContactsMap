//
//  AppRouter.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 29/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import UIKit

final class AppRouter {
    
    private var window: UIWindow
    private var navigationController: UINavigationController
    
    private var appLaunchOptions: [UIApplicationLaunchOptionsKey: Any]?
    
    private lazy var client: ContactClient = ContactClient()
    private lazy var storage: StorageController = StorageController()
    
    private lazy var provider: DataProvider = {
        return DataProvider(client: self.client, storage: self.storage)
    }()
    
    init(appLaunchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        self.appLaunchOptions = appLaunchOptions
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navigationController = UINavigationController()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showInitialViewController() {
        let controller = ContactsTableViewController(provider: self.provider, delegate: self)
        navigationController.viewControllers = [controller]
    }
    
    func showContactDetailViewController(for contact: Contact, from presentingViewController: UIViewController? = nil) {
        let controller = DetailContactViewController(provider: self.provider, contact: contact)
        
        if let presentingViewController = presentingViewController {
            let modalContainer = ModalContainerViewController(rootViewController: controller)
            presentingViewController.present(modalContainer, animated: true, completion: nil)
        } else {
            navigationController.pushViewController(controller, animated: true)
        }
    }
}

extension AppRouter : ContactsTableViewControllerDelegate {
    
    func contactsTableViewController(_ controller: ContactsTableViewController, didSelect contact: Contact) {
        if controller is ContactsTableViewController {
            showContactDetailViewController(for: contact)
        }
    }
}


