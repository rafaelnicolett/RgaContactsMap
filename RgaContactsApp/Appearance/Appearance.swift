//
//  Appearance.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 29/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import UIKit

struct Appearance {
    
    static let tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    static let searchBarTintColor = UIColor(red:0.976, green:0.976, blue:0.976, alpha:1)
    static let lightTextColor = UIColor(red:0.56, green:0.556, blue:0.581, alpha:1)
    
    static func install() {
        UIWindow.appearance().tintColor = tintColor
    }
    
}
