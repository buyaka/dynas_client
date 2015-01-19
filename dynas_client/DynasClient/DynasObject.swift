//
//  DynasObject.swift
//  dynas_client
//
//  Created by Buyaka on 1/14/15.
//  Copyright (c) 2015 demo. All rights reserved.
//

import Foundation

class DynasObject : NSObject {
    
    var SEARCH_ENDPOINT : String = "crud_index"
    var CRUD_ENDPOINT : String = "crud_at"
    
    var id : String = ""
    var entity_name : String = ""
    
    func fromJson(json: String) {
        var error : NSError?
        let JSONData = json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        let JSONDictionary: Dictionary = NSJSONSerialization.JSONObjectWithData(JSONData!, options: nil, error: &error) as NSDictionary
        
        // Loop
        for (key, value) in JSONDictionary {
            let keyName = key as String
            let keyValue: String = value as String
            
            // If property exists
            if (self.respondsToSelector(NSSelectorFromString(keyName))) {
                self.setValue(keyValue, forKey: keyName)
            }
        }
    }
    
    func toJson() {
        
    }
}
