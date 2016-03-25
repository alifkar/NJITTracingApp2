//
//  StartMenu.swift
//  NJITTracingApp
//
//  Created by Seyyed Sajjadpour on 1/6/1395 AP.
//  Copyright © 1395 Alif Karovalia. All rights reserved.
//

import Foundation
import UIKit

class StartMenu: UITableViewController {
 

   let menuList = ["View Map", "Start Tracing", "Stop Tracing", "Statistics", "Frequently Visited Places"]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        cell = tableView.dequeueReusableCellWithIdentifier("menu_cell")
        cell.textLabel?.text = menuList[indexPath.row]
        return cell
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
}