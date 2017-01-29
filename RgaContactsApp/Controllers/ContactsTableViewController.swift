//
//  ContactsTableViewController.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 29/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ContactsTableViewControllerDelegate: class {
    func contactsTableViewController(_ controller: ContactsTableViewController, didSelect contact: Contact)
}

class ContactsTableViewController: UITableViewController {
    
    weak var provider: DataProvider!
    private weak var delegate: ContactsTableViewControllerDelegate?
    
    init(provider: DataProvider, delegate: ContactsTableViewControllerDelegate? = nil) {
        self.provider = provider
        self.delegate = delegate
        
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let disposeBag = DisposeBag()
    
    private struct Constants {
        static let cellIdentifier = "cellContact"
    }
    
    /// Set this to update the table view
    var contactViewModels = [ContactViewModel]() {
        didSet {
            tableView.reload(oldData: oldValue, newData: contactViewModels)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        let loadContacts = tableView.rx.contentOffset.debounce(0.3, scheduler: MainScheduler.instance)
            .flatMap { (point) -> Observable<[Contact]> in
                return self.provider.getContacts()
        }
        
        loadContacts.observeOn(MainScheduler.instance).subscribe { event in
            switch event {
            case .next(let contacts):
                if !contacts.isEmpty {
                    self.contactViewModels = contacts.map({ ContactViewModel(contact: $0, dataProvider: self.provider) })
                }
            default: break
            }
        }.addDisposableTo(self.disposeBag)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ContactTableViewCell
        
        cell.viewModel = contactViewModels[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.contactsTableViewController(self, didSelect: contactViewModels[indexPath.row].contact)
    }
    
}

