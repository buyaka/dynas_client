//
//  News.swift
//  dynas_client
//
//  Created by Buyaka on 1/14/15.
//  Copyright (c) 2015 demo. All rights reserved.
//

import Foundation

class News : DynasObject {
    var title : String = String()
    var content : String = String()
    var url : String = String()
    var type: String = String()
    
    override init() {
        super.init()
        self.entity_name = "news"
    }
    
}
