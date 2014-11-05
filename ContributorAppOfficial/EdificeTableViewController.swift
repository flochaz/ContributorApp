//
//  ConstructionTableViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/13/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit

class EdificeTableViewController: UITableViewController {
    
    let SubConstructionTypes =  ["Private", "Public", "Ephemeral"]
    
    var itemIdentifier:String!
    var tableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for subConstructionType in SubConstructionTypes{
            self.tableData.append(subConstructionType);
        }
        
        if(!itemIdentifier.isEmpty){
            println("From EdificeTableViewController Test variable transfer : " + itemIdentifier)
        }else{
            println("From EdificeTableViewController  test variable Not setted")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let alert = UIAlertController(title: "Item selected", message: "You selected item \(indexPath.row) with value \(tableData[indexPath.row])", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: {
                (alert: UIAlertAction!) in println("An alert of type \(alert.style.hashValue) was tapped!")
        }))
        var item:Item = SwiftCoreDataHelper.getItemFromIdentifier(self.itemIdentifier)
        var subConstructionType:String =  tableData[indexPath.row]
        SwiftCoreDataHelper.addSubConstructionTypeToItem(item, subConstructionType: subConstructionType)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var svc = segue.destinationViewController as LocationViewController;
        if(!itemIdentifier.isEmpty){
            svc.itemIdentifier = itemIdentifier
        }else{
            svc.itemIdentifier = "NO IDENTIFIER"
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
