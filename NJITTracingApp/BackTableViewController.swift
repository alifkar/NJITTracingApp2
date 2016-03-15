//
//  BackTableViewController.swift
//  FindMe
//
//  Created by AnGie on 3/12/16.
//  Copyright © 2016 AnGie. All rights reserved.
//
/* A View Controller that acts as a main-menu w/ features from SWRevealViewController--a public github project */

import Foundation

var username : String!

class BackTableViewController: UITableViewController {
    
    var TableArray = [String]()
    var ImageArray = [String]()
    var currentUser: String!
    
    override func viewDidLoad() {
        TableArray = ["map", "favorites", "history", "settings", "about"]
        ImageArray = ["target.png", "pin.png", "black.png", "clock.png", "settings.png"]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        currentUser = username
        tableView.dequeueReusableCellWithIdentifier("user_cell")?.textLabel?.text = currentUser
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.beginUpdates()
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        tableView.endUpdates()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell!
       
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("user_cell")
            cell?.textLabel?.text = username
            let image : UIImage = UIImage(named: ImageArray[0])!
            cell.imageView?.image = image
            cell.imageView?.transform = CGAffineTransformMakeScale(0.25, 0.25)
            
        }
        else if indexPath.row == 1{
            cell = tableView.dequeueReusableCellWithIdentifier("map_cell")
            cell.textLabel?.text = TableArray[0]
            let image : UIImage = UIImage(named: ImageArray[1])!
            cell.imageView?.image = image
            cell.imageView?.transform = CGAffineTransformMakeScale(0.125, 0.125)

        }
        else if indexPath.row == 2 {
            cell = tableView.dequeueReusableCellWithIdentifier("favorites_cell", forIndexPath: indexPath)
            cell.textLabel?.text = TableArray[1]
            let image : UIImage = UIImage(named: ImageArray[2])!
            cell.imageView?.image = image
            cell.imageView?.transform = CGAffineTransformMakeScale(0.125, 0.125)

        }
        else if indexPath.row == 3{
            cell = tableView.dequeueReusableCellWithIdentifier("history_cell", forIndexPath: indexPath)
            cell.textLabel?.text = TableArray[2]
            let image : UIImage = UIImage(named: ImageArray[3])!
            cell.imageView?.image = image
            cell.imageView?.transform = CGAffineTransformMakeScale(0.125, 0.125)

        }
        else if indexPath.row == 4{
            cell = tableView.dequeueReusableCellWithIdentifier("settings_cell", forIndexPath: indexPath)
            cell.textLabel?.text = TableArray[3]
            let image : UIImage = UIImage(named: ImageArray[4])!
            cell.imageView?.image = image
            cell.imageView?.transform = CGAffineTransformMakeScale(0.125, 0.125)

        }
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("about_cell", forIndexPath: indexPath)
            cell.textLabel?.text = TableArray[4]
        }
        return cell
    }
}