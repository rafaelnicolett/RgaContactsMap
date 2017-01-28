//
//  Contact.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation

struct Contact {
    let name: String
    let email: String
    let born: String
    let bio: String
    var photo: String
}

extension Contact : Equatable { }

func == (lhs: Contact, rhs: Contact) -> Bool {
    return lhs.name == rhs.name
        && lhs.email == rhs.email
        && lhs.born == rhs.born
        && lhs.bio == rhs.bio
        && lhs.photo == rhs.photo
}
