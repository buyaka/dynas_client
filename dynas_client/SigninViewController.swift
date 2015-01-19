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
    @IBOutlet weak var activityIndicatorView: UIView!
    
    @IBAction func signinTapped(sender: UIButton) {
        
        self.activityIndicatorView.hidden = false
        if countElements(self.txtEmail.text) > 0 && countElements(self.txtPassword.text) > 0  {
            let apiclient = Dynas()
            apiclient.signin(self.txtEmail.text, password: self.txtPassword.text, completion: { (cdata, cerror, cresponse) -> Void in
                /*if (cresponse.statusCode == 200) {
                    // save API AuthToken and ExpiryDate in Keychain
                    apiclient.saveApiTokenInKeychain(cdata)
                    apiclient.updateUserLoggedInFlag()
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    var msg = cdata["message"]! as String
                    self.displayAlertMessage("Response", alertDescription: msg)
                }*/
                
                println(cresponse)
                if (cerror == nil) {
                    apiclient.saveApiTokenInKeychain(cdata)
                    apiclient.updateUserLoggedInFlag()
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
                    self.displayAlertMessage("Response", alertDescription: cerror.description)
                }
            })
        } else {
            self.displayAlertMessage("Parameters Required", alertDescription: "Some of the required parameters are missing")
        }
        
        self.activityIndicatorView.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayAlertMessage(alertTitle: String, alertDescription: String) -> Void {
        // hide activityIndicator view and display alert message
        self.activityIndicatorView.hidden = true
        let errorAlert = UIAlertView(title:alertTitle, message:alertDescription, delegate:nil, cancelButtonTitle:"OK")
        errorAlert.show()
    }
    
}
