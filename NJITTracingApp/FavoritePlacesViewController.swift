//
//  FavoritePlacesViewController.swift
//  FindMe
//
//  Created by AnGie on 3/13/16.
//  Copyright © 2016 AnGie. All rights reserved.
//
/* View Controller that will hold user's frequently visited locations displayed as points-of-interest */

import Foundation
import MapKit

class FavoritePlacesViewController: UITableViewController {
    
    @IBOutlet weak var menuLabel: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLabel.target = self.revealViewController()
        menuLabel.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}