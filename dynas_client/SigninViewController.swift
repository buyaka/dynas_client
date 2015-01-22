//
//  SigninViewController.swift
//  dynas_client
//
//  Created by Buyaka on 1/18/15.
//  Copyright (c) 2015 demo. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func signinTapped(sender: UIButton) {
        
        DynasHelper.sharedInstance.showActivityIndicator(self.view)
        if countElements(self.txtEmail.text) > 0 && countElements(self.txtPassword.text) > 0  {
            
            Dynas.sharedInstance.signin(self.txtEmail.text, password: self.txtPassword.text, completion: { (cdata, cerror, cresponse) -> Void in
                
                if (cerror == nil) {
                    Dynas.sharedInstance.saveApiTokenInKeychain(cdata)
                    Dynas.sharedInstance.updateUserLoggedInFlag()
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                    /*var stts = cdata["status"]! as Int
                    if (stts == 200) {
                        // save API AuthToken and ExpiryDate in Keychain
                        apiclient.saveApiTokenInKeychain(cdata)
                        apiclient.updateUserLoggedInFlag()
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        var msg = cdata["message"]! as String
                        self.displayAlertMessage("Response", alertDescription: msg)
                    }*/
                } else {
                    DynasHelper.sharedInstance.displayAlertMessage("Response", alertDescription: cerror.description)
                }
            })
        } else {
            DynasHelper.sharedInstance.displayAlertMessage("Parameters Required", alertDescription: "Some of the required parameters are missing")
        }
        
        DynasHelper.sharedInstance.hideActivityIndicator(self.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
