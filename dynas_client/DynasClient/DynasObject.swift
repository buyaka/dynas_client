//
//  DynasObject.swift
//  dynas_client
//
//  Created by Buyaka on 1/14/15.
//  Copyright (c) 2015 demo. All rights reserved.
//

import Foundation

class DynasObject {
    
    var SEARCH_ENDPOINT : String = "crud_index"
    var CRUD_ENDPOINT : String = "crud_at"
    let dynas_manager = Dynas.sharedInstance
    
    var id : String = ""
    var entity_name : String = ""
    
    func getDatas(filter: String) -> NSDictionary!  {
        var retData: NSDictionary! = nil
        dynas_manager.getDatas(self, filter: filter) { (cdata, cerror) -> Void in
            if (cerror == nil) {
                retData = cdata
            } else {
                println(cerror.description)
            }
        }
        return retData
    }
    
    func getData(id: String) {
        self.id = id
        dynas_manager.getData(self)
    }
    
    func saveData() {
        dynas_manager.saveData(self)
    }
    
    func updateData() {
        dynas_manager.updateData(self)
    }
    
    func deleteData() {
        dynas_manager.deleteData(self)
    }
}
