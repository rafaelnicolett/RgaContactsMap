//
//  SearchContactAdapter.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 28/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import Foundation
import SwiftyJSON

final class SearchContactAdapter: Adapter<JSON, SearchResults<Contact>> {
    
    override func adapt() -> Result<SearchResults<Contact>, AdapterError> {
        guard let itemArray = input.array else {
            return .error(.missingRequiredFields)
        }
        
        let items: [Contact] = itemArray.flatMap { jsonContact-> Contact? in
            let result = ContactAdapter(input: jsonContact).adapt()
            switch result {
            case .error(_): return nil
            case .success(let contact): return contact
            }
        }
        
        let searchResults = SearchResults<Contact>(items: items)
        
        return .success(searchResults)
    }
}
