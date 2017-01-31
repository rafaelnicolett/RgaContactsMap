//
//  StorageController.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

final class StorageController: Storage {
    
    private let configuration: Realm.Configuration
    
    private let queue = DispatchQueue(label: "Storage", qos: .background)
    
    func realm() -> Realm {
        return try! Realm(configuration: self.configuration)
    }
    
    init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }
    
    func store(contacts: [Contact], completion: ((StorageError?) -> ())?) {
        queue.async {
            let realmContact = contacts.map(RealmContact.init)
            do {
                try self.insertOrUpdate(objects: realmContact) { oldContact, newContact in
                    return oldContact.id == nil && newContact.id != nil
                }
                
                completion?(nil)
            } catch {
                completion?(.exception(error))
            }
        }
    }
    
    func getContacts() -> Observable<[Contact]> {
        let contacts = self.realm().objects(RealmContact.self).sorted(byProperty: "id")
        
        return Observable.from(contacts).map { realmContacts in
            return realmContacts.map({ $0.contact })
        }
    }
    
    func saveContact(contact: Contact) {
        let realmContact = RealmContact(contact: contact)
        do {
            try self.insertOrUpdate(object: realmContact) { oldContact, newContact in
                return newContact.id != nil
            }
        } catch {

        }
    }
    
    func deleteContact(contact: Contact) {
        let realmContact = RealmContact(contact: contact)
        do {
            if let existingObject = self.realm().object(ofType: RealmContact.self, forPrimaryKey: realmContact.id) {
                    try self.realm().write {
                        self.realm().delete(existingObject)
                }
            }
        } catch {
            
        }
    }
    
    private func fetchOrCreate<T: Object, K>(type: T.Type, primaryKey: K, create: () -> T) throws -> T {
        let realm = self.realm()
        
        if let object = realm.object(ofType: type, forPrimaryKey: primaryKey) {
            return object
        } else {
            let object = create()
            
            try realm.write {
                realm.add(object)
            }
            
            return object
        }
    }
    
    private func insertOrUpdate<T: Object>(objects: [T], updateDecisionHandler: @escaping (_ oldObject: T, _ newObject: T) -> Bool) throws {
        try objects.forEach({ try self.insertOrUpdate(object: $0, updateDecisionHandler: updateDecisionHandler) })
    }
    
    private func insertOrUpdate<T: Object>(object: T, updateDecisionHandler: @escaping (_ oldObject: T, _ newObject: T) -> Bool) throws {
        let realm = self.realm()
        
        guard let primaryKey = T.primaryKey() else {
            fatalError("insertOrUpdate can't be used for objects without a primary key")
        }
        
        guard let primaryKeyValue = object.value(forKey: primaryKey) else {
            fatalError("insertOrUpdate can't be used for objects without a primary key")
        }
        
        if let existingObject = realm.object(ofType: T.self, forPrimaryKey: primaryKeyValue) {
            if updateDecisionHandler(existingObject, object) {
                try realm.write {
                    realm.add(object, update: true)
                }
            }
        } else {
            try realm.write {
                createUnique(object: object)
                realm.add(object)
            }
        }
    }
    
    func createUnique<T: Object>(object: T) {
        var myvalue = realm().objects(T.self).max(ofProperty: "id") ?? 0
        myvalue = myvalue + 1
        object.setValue(myvalue, forKey: "id")
        
    }
}



