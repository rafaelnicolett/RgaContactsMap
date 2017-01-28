//
//  ContactApiHandler.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation
import Siesta

public struct ContactApiErrorErrorHandler: ResponseTransformer {
    
    public func process(_ response: Response) -> Response {
        switch response {
        case .success:
            return response
        case .failure(var error):
            error.userMessage = error.jsonDict["message"] as? String ?? error.userMessage
            return .failure(error)
        }
    }
}
