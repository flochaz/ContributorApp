//
//  ConstructionTableViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/13/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit

class ConstructionTableViewController: UITableViewController {

    var itemIndetifier:NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemIndetifier != nil){
        println("Test variable transfer : " + itemIndetifier)
        }else{
            println("test variable Not setted")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
