//
//  ContactViewModel.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation
import IGListKit

final class ContactViewModel : NSObject, IGListDiffable {
    let contact: Contact
    
    private weak var dataProvider: DataProvider?
    
    var id: Int {
        return self.contact.id
    }
    
    var name: String {
        return self.contact.name
    }
    
    var email: String {
        return self.contact.email
    }
    
    var born: String {
        return self.contact.born
    }
    
    var bio: String {
        return self.contact.bio
    }
    
    var photo : String {
        return self.contact.photo
    }
    
    init(contact: Contact, dataProvider: DataProvider? = nil) {
        self.contact = contact
        self.dataProvider = dataProvider
        
        super.init()
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return contact.email as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard let other = object as? ContactViewModel else { return false }
        
        return self.contact == other.contact
    }
}
