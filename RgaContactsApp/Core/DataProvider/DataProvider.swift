//
//  DataProvider.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation
import RxSwift

final class DataProvider {
    
    private let client: ApiClient
    private let storage: Storage
    
    init(client: ApiClient, storage: Storage) {
        self.client = client
        self.storage = storage
    }
    
    var error = Variable<Error?>(nil)
    
    func getContacts() -> Observable<[Contact]> {
        if (UserDefaults.standard.value(forKey: "firt_access") == nil) {
            client.getContacts() { [weak self] result in
                switch result {
                case .success(let results):
                    UserDefaults.standard.setValue(true, forKey: "firt_access")
                    self?.storage.store(contacts: results.items, completion: nil)
                case .error(let error):
                    self?.error.value = error
                }
            }
            
            
        }
        
       return storage.getContacts()
    }
    
    func saveContact(contact: Contact) {
        storage.saveContact(contact: contact)
    }
    
    func deleteContact(contact: Contact) {
        storage.deleteContact(contact: contact)
    }
}


