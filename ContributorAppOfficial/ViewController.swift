//
//  ViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 9/24/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    var itemIndetifier:NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemIndetifier != nil){
            println("From ViewController Test variable transfer : " + itemIndetifier)
        }else{
            println("From ViewController  test variable Not setted")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var svc = segue.destinationViewController as ConstructionTableViewController;
        
        svc.itemIndetifier = "test2"
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

