//
//  ViewController.swift
//  dynas_client
//
//  Created by Buyaka on 1/13/15.
//  Copyright (c) 2015 demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    var tableData = [News]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        self.tableView.addPullToRefresh({ [weak self] in
            
            self?.tableData.removeAll(keepCapacity: true)
            
            let nws: News = News()
            let data = DynasHelper.sharedInstance.getDatas(nws, filter : "")
            
            if (data != nil) {
                for item in data {
                    let nws = News()
                    nws.fromJson(item as String)
                    self?.tableData.append(nws)
                    println(nws.title)
                }
                
                println(self?.tableData.count)
                
                sleep(1)
                self?.tableView.reloadData()
            }
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            // logout and ask user to sign in again if token is expired
            if comparision != NSComparisonResult.OrderedAscending {
            loginController.logoutBtnTapped()
            }
            */
            
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.font = UIFont.italicSystemFontOfSize(18)
        cell.textLabel?.textColor = UIColor(red: 44/255, green: 62/255, blue: 88/255, alpha: 1.0)
        let n = tableData[indexPath.row] as News
        cell.textLabel?.text = n.title
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.tableView.fixedPullToRefreshViewForDidScroll()
    }

    
    
}

