//
//  ViewController.swift
//  dynas_client
//
//  Created by Buyaka on 1/13/15.
//  Copyright (c) 2015 demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "CELL"
    var tableData = Array<News>()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLogin()
    }
    
    @IBAction func doSignout(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nil, forKey: "userLoggedIn")
        defaults.synchronize()

        let loginController: SigninViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SinginViewController") as SigninViewController
        self.navigationController?.presentViewController(loginController, animated: true, completion: nil)
            
        /*
        Dynas.sharedInstance.signout(token: String, completion: { (cdata, cerror) -> Void in
            if (cerror == nil) {
                
            } else {
                DynasHelper.sharedInstance.displayAlertMessage("Error", alertDescription: cerror.description)
            }
        })
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLineEtched
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
    }
    

    @IBAction func doRefresh(sender: UIBarButtonItem) {
        DynasHelper.sharedInstance.showActivityIndicator(self.view)
        var nws = News()
        Dynas.sharedInstance.getDatas(nws, filter: "", completion: { (cdata, cerror) -> Void in
            if (cerror == nil) {
                if cdata.count > 0 {
                   self.tableData.removeAll(keepCapacity: false)
                }
                
                for element in cdata {
                    //TODO: Model serialize move into DynasLibrary
                    var n = News()
                    n.title = (element as NSDictionary)["name"] as String
                    n.id = (element as NSDictionary)["id"] as String
                    n.content = (element as NSDictionary)["desc"] as String
                    self.tableData.append(n)
                }
                
                self.tableView.reloadData()
            } else {
                DynasHelper.sharedInstance.displayAlertMessage("Error", alertDescription: cerror.description)
            }
            DynasHelper.sharedInstance.hideActivityIndicator(self.view)
            
        })
        
        
    }
    
    func checkLogin() {
        // check if user is signed in
        let defaults = NSUserDefaults.standardUserDefaults()
        let loginController: SigninViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SinginViewController") as SigninViewController
        
        // is user is not signed in display controller to sign in or sign up
        if defaults.objectForKey("userLoggedIn") == nil {
            self.navigationController?.presentViewController(loginController, animated: true, completion: nil)
        } else {
            // check if API token has expired
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let userTokenExpiryDate : NSString? = KeychainAccess.passwordForAccount("Auth_Token_Expiry", service: "KeyChainService")
            let dateFromString : NSDate? = dateFormatter.dateFromString(userTokenExpiryDate!)
            let now = NSDate()
            
            let comparision = now.compare(dateFromString!)
            /*
            // check if should fetch new data
            if shouldFetchNewData {
            shouldFetchNewData = false
            self.setNavigationItems()
            loadSelfieData()
            }
            */
            // logout and ask user to sign in again if token is expired
            if comparision != NSComparisonResult.OrderedAscending {
                self.doSignout(self)
            }
            
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: NewsCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as NewsCell
        let n = tableData[indexPath.row] as News
        cell.lblTitle.text = n.title
        cell.lblDesc.text = n.content
        cell.lblType.text = n.url
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            tableData.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    /*
    
    //Demo for call library function
    
    DynasHelper.sharedInstance.showActivityIndicator(self.view)
    Dynas.sharedInstance.getCouponsWithBeacon("1234567890", completion: { (cdata, cerror) -> Void in
    
    println (cdata)
    self.tableView.reloadData()
    DynasHelper.sharedInstance.hideActivityIndicator(self.view)
    
    })
    */
    
}

