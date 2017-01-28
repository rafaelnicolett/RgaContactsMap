//
//  ContactApi.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

final class ContactApi {
    
    private struct Endpoints {
        static let contacts = "v1/content.json"
    }
    
    private let service = Service(baseURL: "http://rgasp-mobile-test.s3-website-sa-east-1.amazonaws.com/")
    
    init() {
        service.configure("**") { config in
            //config.useNetworkActivityIndicator()
            
            config.pipeline[.parsing].add(self.jsonParser, contentTypes: ["*/json"])
            
            config.pipeline[.cleanup].add(ContactApiErrorErrorHandler())
        }
        
        service.configureTransformer(Endpoints.contacts) {
            try self.failableAdapt(using: SearchContactAdapter(input: $0.content as JSON))
        }
    }
    
    func getContacts() -> Resource {
        return service
            .resource(Endpoints.contacts)
    }
    
    private let jsonParser = ResponseContentTransformer { JSON($0.content as AnyObject) }
    
    private func failableAdapt<T>(using adapter: Adapter<JSON, T>) throws -> T {
        let result = adapter.adapt()
        switch result {
        case .success(let entity):
            return entity
        case .error(let error):
            throw error
        }
    }
    
}



