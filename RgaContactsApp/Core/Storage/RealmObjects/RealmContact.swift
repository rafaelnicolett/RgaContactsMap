//
//  RealmContact.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmContact: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var email = ""
    dynamic var born = ""
    dynamic var bio = ""
    dynamic var photo = ""
    
    override static func indexedProperties() -> [String] {
        return ["name"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension RealmContact {
    
    convenience init(contact: Contact) {
        self.init()
        
        self.id = contact.id
        self.email = contact.email
        self.name = contact.name
        self.born = contact.born
        self.bio = contact.bio
        self.photo = contact.photo
    }
    
    var contact: Contact {
        return Contact(
            id: id,
            name: name,
            email: email,
            born: born,
            bio: bio,
            photo: photo
        )
    }
}

