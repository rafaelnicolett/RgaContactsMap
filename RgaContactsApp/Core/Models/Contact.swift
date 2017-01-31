//
//  Contact.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation

struct Contact {
    var id: Int
    var name: String
    var email: String
    var born: String
    var bio: String
    var photo: String
}

extension Contact : Equatable { }

func == (lhs: Contact, rhs: Contact) -> Bool {
    return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.email == rhs.email
        && lhs.born == rhs.born
        && lhs.bio == rhs.bio
        && lhs.photo == rhs.photo
}

class ContactFactory {
    func createNewContact() -> Contact {
        return Contact(id: 0, name: "", email: "", born: "", bio: "", photo: "")
    }
}
