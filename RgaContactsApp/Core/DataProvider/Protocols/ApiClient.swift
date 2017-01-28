//
//  ApiClient.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation

enum APIError: Error {
    case unknown
    case http(Error)
    case adapter
}

protocol ApiClient {
    func getContacts(completion: @escaping (Result<SearchResults<Contact>, APIError>) -> ())
}

