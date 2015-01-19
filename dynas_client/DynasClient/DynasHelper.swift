//
//  DynasHelper.swift
//  dynas_client
//
//  Created by Buyaka on 1/20/15.
//  Copyright (c) 2015 demo. All rights reserved.
//

import Foundation

let _SingletonSharedDynasHelperInstance = DynasHelper()

class DynasHelper {
    
    class var sharedInstance: DynasHelper {
        return _SingletonSharedDynasHelperInstance
    }
    
    let dynas_manager = Dynas.sharedInstance
    
    func getDatas(object: DynasObject, filter: String) -> NSArray!  {
        let retData: NSArray! = nil
        dynas_manager.getDatas(object, filter: filter) { (cdata, cerror) -> Void in
            if (cerror == nil) {
                retData.arrayByAddingObjectsFromArray(cdata)
                println (retData[0]["desc"])
            } else {
                println(cerror.description)
            }
        }
        //TODO yagaad nil utga butsaagaad bgaag oloh
        return retData
    }
    
    func getData(object: DynasObject) {
        dynas_manager.getData(object)
    }
    
    func saveData(object: DynasObject) {
        dynas_manager.saveData(object)
    }
    
    func updateData(object: DynasObject) {
        dynas_manager.updateData(object)
    }
    
    func deleteData(object: DynasObject) {
        dynas_manager.deleteData(object)
    }

    
}