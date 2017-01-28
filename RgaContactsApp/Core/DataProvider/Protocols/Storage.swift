//
//  Storage.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation
import RxSwift

enum StorageError: Error {
    case notFound(String?)
    case exception(Error)
}

protocol Storage: class {
    
    func store(contacts: [Contact], completion: ((StorageError?) -> ())?)
    func getContacts() -> Observable<[Contact]>
}
