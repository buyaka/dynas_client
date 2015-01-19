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
    @IBOutlet weak var activityIndicatorView: UIView!
    
    @IBAction func singupTapped(sender: UIButton) {
        // start activity indicator
        self.activityIndicatorView.hidden = false
        
        // validate presence of all required parameters
        if countElements(self.txtFullName.text) > 0 && countElements(self.txtEmail.text) > 0 && countElements(self.txtPassword.text) > 0 && countElements(self.txtPasswordRepeat.text) > 0 {
            
            let a = Dynas.sharedInstance
            a.signup(self.txtFullName.text, email: self.txtEmail.text, password: self.txtPassword.text, completion: { (cdata, cerror) -> Void in
                if (cerror == nil) {
                    println(cdata)
                    var msg = cdata["message"]! as String
                    var stts = cdata["status"]! as Int
                    if (stts == 200) {
                        self.displayAlertMessage("Response", alertDescription: msg)
                    } else {
                        self.displayAlertMessage("Response", alertDescription: msg)
                    }
                } else {
                    self.displayAlertMessage("Response", alertDescription: cerror.description)
                }
            })
            
        } else {
            self.displayAlertMessage("Parameters Required", alertDescription: "Some of the required parameters are missing")
        }
        
        self.activityIndicatorView.hidden = true
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
    
    func displayAlertMessage(alertTitle:NSString, alertDescription:NSString) -> Void {
        // hide activityIndicator view and display alert message
        self.activityIndicatorView.hidden = true
        let errorAlert = UIAlertView(title:alertTitle, message:alertDescription, delegate:nil, cancelButtonTitle:"OK")
        errorAlert.show()
    }
    
}
