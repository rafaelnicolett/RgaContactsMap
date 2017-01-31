//
//  ContactAdapter.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation
import SwiftyJSON

private extension Contact {
    struct Keys {
        static let name = "name"
        static let email = "email"
        static let born = "born"
        static let bio = "bio"
        static let photo = "photo"
        static let oldUrl = "https://s3-sa-east-1.amazonaws.com/rgasp-mobile-test/v1/"
        static let newUrl = "http://rgasp-mobile-test.s3-website-sa-east-1.amazonaws.com/v1/"
    }
}

final class ContactAdapter: Adapter<JSON, Contact> {
    
    override func adapt() -> Result<Contact, AdapterError> {
        
        let name = input[Contact.Keys.name].stringValue
        let email = input[Contact.Keys.email].stringValue
        let born = input[Contact.Keys.born].stringValue
        let bio = input[Contact.Keys.bio].stringValue
        let photo = input[Contact.Keys.photo].stringValue.replacingOccurrences(of: Contact.Keys.oldUrl, with: Contact.Keys.newUrl)
        
        let contact = Contact(
            id: 0,
            name: name,
            email: email,
            born: born,
            bio: bio,
            photo: photo
        )
        
        return .success(contact)
    }
}
