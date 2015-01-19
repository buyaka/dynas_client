//
//  Dynas.swift
//  dynas_client
//
//  Created by Buyaka on 1/14/15.
//  Copyright (c) 2015 demo. All rights reserved.
//

import Foundation
import Alamofire

let _SingletonSharedInstance = Dynas()

class Dynas {
    
    class var sharedInstance: Dynas {
        return _SingletonSharedInstance
    }
    
    let KEY_API_USER_TOKEN = "api_authtoken"
    let KEY_API_USER_TOKEN_EXPIRY = "authtoken_expiry"
    
    //let API_AUTH_NAME = "<YOUR_DYNAS_API_ADMIN_NAME>"
    //let API_AUTH_PASSWORD = "<YOUR_DYNAS_API_PASSWORD>"
    let API_AUTH_TOKEN = "<YOUR_DYNAS_API_TOKEN>"
    //let MEMBERID = "<YOUR_MEMBERID>"
    //let APPID = "<YOUR_APPID>"
    
    let MEMBERID = "1Rfx9V6fEuN9gh"
    let APPID = "1S9oCLkYxgfEF4"
    
    var BASE_URL : String = "http://api.dynas.mn/v1/"
    let manager = Alamofire.Manager.sharedInstance
    
    func addHeader() {
        manager.session.configuration.HTTPAdditionalHeaders = [
            "MEMBERID": MEMBERID,
            "APPID": APPID
        ]
    }
    
    func signin(email: String, password: String, completion:(cdata: NSDictionary!, cerror: NSError!) -> Void) {
        addHeader()
        manager.request(.POST, BASE_URL + "signin", parameters: ["email":email, "password": password])
            .responseJSON() {(request, response, JSON, error) in
                if (error != nil) {
                    println(response)
                    completion(cdata: nil, cerror: error)
                } else {
                    completion(cdata: JSON as NSDictionary, cerror: nil)
                }
        }
        
    }
    
    func signin(email: String, password: String, completion:(cdata: NSDictionary!, cerror: NSError!, cresponse: NSHTTPURLResponse?) -> Void) {
        addHeader()
        manager.request(.POST, BASE_URL + "signin", parameters: ["email":email, "password": password])
            .responseJSON() {(request, response, JSON, error) in
                if (error != nil) {
                    completion(cdata: nil, cerror: error, cresponse: response)
                } else {
                    completion(cdata: JSON as NSDictionary, cerror: nil, cresponse: response)
                }
        }
        
    }
    
    func signout(email: String, token: String) {
        addHeader()
        manager.request(.POST, BASE_URL + "signout", parameters: ["email": email, "token":token])
            .responseJSON() {(request, response, data, error) in
                if (error != nil) {
                    println(error)
                } else {
                    var err: NSError?
                    let jsonData: NSData = data as NSData
                    var jsonResult = NSJSONSerialization.JSONObjectWithData(jsonData, options:NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                    
                    if (err != nil) {
                        println("JSON Error: ¥(err.description)")
                    }
                    println(data)
                }
        }
        
    }
    
    func signup(fullname: String, email: String, password: String, completion:(cdata: NSDictionary!, cerror: NSError!) -> Void) {
        addHeader()
        manager.request(.POST, BASE_URL + "signup", parameters: ["full_name":fullname, "email":email, "password": password])
            .responseJSON() {(request, response, JSON, error) in
                if (error != nil) {
                    completion(cdata: nil, cerror: error)
                } else {
                    completion(cdata: JSON as NSDictionary, cerror: nil)
                }
        }
        
    }

    
    func saveApiTokenInKeychain(tokenDict:NSDictionary) {
        // Store API AuthToken and AuthToken expiry date in KeyChain
        tokenDict.enumerateKeysAndObjectsUsingBlock({ (dictKey, dictObj, stopBool) -> Void in
            var myKey = dictKey as NSString
            var myObj = dictObj as NSString
            
            if myKey == "api_authtoken" {
                KeychainAccess.setPassword(myObj, account: "Auth_Token", service: "KeyChainService")
            }
            
            if myKey == "authtoken_expiry" {
                KeychainAccess.setPassword(myObj, account: "Auth_Token_Expiry", service: "KeyChainService")
            }
        })
    }
    
    func updateUserLoggedInFlag() {
        // Update the NSUserDefaults flag
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("loggedIn", forKey: "userLoggedIn")
        defaults.synchronize()
    }
    
    func getErrorMessage(error: NSError) -> NSString {
        var errorMessage : NSString
        
        // return correct error message
        if error.domain == "DynasError" {
            let userInfo = error.userInfo as NSDictionary!
            errorMessage = userInfo.valueForKey("message") as NSString
        } else {
            errorMessage = error.description
        }
        
        return errorMessage
    }
    
    
    func getDatas(object: DynasObject, filter: String, completion:(cdata: NSDictionary!, cerror: NSError!) -> Void){
        addHeader()
        manager.request(.GET, BASE_URL + object.SEARCH_ENDPOINT, parameters: ["entity":object.entity_name, "data":""]).response { (request, response, JSON, error) in
            
            if (error != nil) {
                completion(cdata: nil, cerror: error)
            } else {
                if (response?.statusCode == 200) {
                    var parseError: NSError?
                    let parsedObject = NSJSONSerialization.JSONObjectWithData(JSON as NSData,
                        options: NSJSONReadingOptions.MutableContainers,
                        error:&parseError) as? NSDictionary
                    
                    if (parseError == nil) {
                            println(parsedObject)
                            completion(cdata: parsedObject, cerror: nil)
                    } else {
                        completion(cdata: nil, cerror: parseError)
                    }
                } else {
                    completion(cdata: nil, cerror: error)
                }
            }
        }
        
    }
    
    func getData(object: DynasObject) {
        
    }
    
    func saveData(object: DynasObject) {
        
    }
    
    func updateData(object: DynasObject) {
        
    }
    
    func deleteData(object: DynasObject) {
        
    }
        
}
