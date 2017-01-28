//
//  Adapter.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

enum AdapterError: Error {
    case notImplemented
    case missingRequiredFields
}

class Adapter<I, O> {
    
    var input: I
    
    required init(input: I) {
        self.input = input
    }
    
    func adapt() -> Result<O, AdapterError> {
        return Result.error(.notImplemented)
    }
    
}
