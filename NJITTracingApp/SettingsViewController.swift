//
//  SettingsViewController.swift
//  FindMe
//
//  Created by AnGie on 3/12/16.
//  Copyright © 2016 AnGie. All rights reserved.
//
/* View Controller holding user's settings and enables editing/signing-out */

import Foundation
import MapKit
import UIKit

class SettingsViewController: UITableViewController{
    
    @IBOutlet weak var menuLabel: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLabel.target = self.revealViewController()
        menuLabel.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("signout_cell", forIndexPath: indexPath)
            return cell
    }
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        let logOutAlert = UIAlertController(title:nil, message: "Are you sure you want to log out?", preferredStyle: .ActionSheet)
        
        let logOutActionHandler = {(action: UIAlertAction!) -> Void in
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.performSegueWithIdentifier("signOut", sender: self)
        }
    
        let logoutAction = UIAlertAction(title: "Log out", style: .Default, handler: logOutActionHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        logOutAlert.addAction(logoutAction)
        logOutAlert.addAction(cancelAction)
        self.presentViewController(logOutAlert, animated: true, completion: nil)
    }
    
}