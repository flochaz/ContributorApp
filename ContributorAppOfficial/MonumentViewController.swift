//
//  ViewController2.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/13/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit

class MonumentViewController: UIViewController {

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
        if segue.destinationViewController is MonumentTableViewController{
            var svc = segue.destinationViewController as MonumentTableViewController;
            
            svc.itemIdentifier = itemIdentifier
        }
    }

}
