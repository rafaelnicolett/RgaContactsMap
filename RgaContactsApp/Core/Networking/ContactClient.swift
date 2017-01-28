//
//  ContactClient.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

extension Siesta.Resource {
    
    var error: APIError {
        if let underlyingError = self.latestError {
            return .http(underlyingError)
        } else {
            return .unknown
        }
    }
}

final class ContactClient: ApiClient {
    
    private let concreteClient = ContactApi()
    
    func getContacts(completion: @escaping (Result<SearchResults<Contact>, APIError>) -> ()) {
        concreteClient.getContacts().addObserver(owner: self) { [weak self] resource, event in
            self?.process(resource, event: event, with: completion)
            }.loadIfNeeded()
    }
    
    private func process<M>(_ resource: Siesta.Resource, event: Siesta.ResourceEvent, with completion: @escaping (Result<M, APIError>) -> ()) {
        switch event {
        case .error:
            completion(.error(resource.error))
        case .newData(_), .notModified:
            if let results: M = resource.typedContent() {
                completion(.success(results))
            } else {
                completion(.error(.adapter))
            }
            
        default: break
        }
    }
}


