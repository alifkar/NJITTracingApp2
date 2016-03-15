//
//  TrackingHistoryViewController.swift
//  FindMe
//
//  Created by AnGie on 3/13/16.
//  Copyright © 2016 AnGie. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class TrackingHistoryViewController: UITableViewController {
    var trackedLocations: [CLLocation] = []
    var trackedAddresses: [String] = []
    @IBOutlet weak var menuLabel: UIBarButtonItem!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLabel.target = self.revealViewController()
        menuLabel.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        trackedLocations = myLocations
        trackedAddresses = myAddresses
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackedLocations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tracking_cell", forIndexPath: indexPath)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy 'at' hh:mm at"
        let dateString = dateFormatter.stringFromDate(trackedLocations[indexPath.row].timestamp)
        
        let addressString = myAddresses[indexPath.row]
        
        cell.detailTextLabel?.text = addressString
        cell.textLabel?.text = dateString
       
        return cell
    }
}