//
//  ViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 9/24/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit
import MapKit

class ConstructionViewController: UIViewController, MKMapViewDelegate {

    var itemIdentifier:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!itemIdentifier.isEmpty){
            println("From ViewController Test variable transfer : " + itemIdentifier)
        }else{
            println("From ViewController  test variable Not setted")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.destinationViewController is ConstructionTableViewController{
        var svc = segue.destinationViewController as! ConstructionTableViewController;
        
        svc.itemIdentifier = itemIdentifier
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

