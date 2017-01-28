//
//  Result.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case error(E)
}

