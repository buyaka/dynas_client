//
//  SignupViewController.swift
//  dynas_client
//
//  Created by Buyaka on 1/18/15.
//  Copyright (c) 2015 demo. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPasswordRepeat: UITextField!
    
    @IBAction func singupTapped(sender: UIButton) {
        
        DynasHelper.sharedInstance.showActivityIndicator(self.view)
        
        // validate presence of all required parameters
        if countElements(self.txtFullName.text) > 0 && countElements(self.txtEmail.text) > 0 && countElements(self.txtPassword.text) > 0 && countElements(self.txtPasswordRepeat.text) > 0 {
            
            let a = Dynas.sharedInstance
            a.signup(self.txtFullName.text, email: self.txtEmail.text, password: self.txtPassword.text, completion: { (cdata, cerror) -> Void in
                if (cerror == nil) {
                    println(cdata)
                    var msg = cdata["message"]! as String
                    var stts = cdata["status"]! as Int
                    if (stts == 200) {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        DynasHelper.sharedInstance.displayAlertMessage("Response", alertDescription: msg)
                    }
                } else {
                    DynasHelper.sharedInstance.displayAlertMessage("Response", alertDescription: cerror.description)
                }
            })
            
        } else {
            DynasHelper.sharedInstance.displayAlertMessage("Parameters Required", alertDescription: "Some of the required parameters are missing")
        }
        
        DynasHelper.sharedInstance.hideActivityIndicator(self.view)
    }
    
    @IBAction func showSigninView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
