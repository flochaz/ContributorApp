//
//  ConstructionTableViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/13/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit

class ConstructionTableViewController: UITableViewController {

    let ConstructionTypes =  ["Monument", "Edifice", "Landscape"]
    
    var itemIdentifier:String!
    var tableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for constructionType in ConstructionTypes{
        self.tableData.append(constructionType);
        }
        
        if(!itemIdentifier.isEmpty){
        println("From table view Test variable transfer : " + itemIdentifier)
        }else{
            println("From table  test variable Not setted")
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
        var item = SwiftCoreDataHelper.getItemFromIdentifier(self.itemIdentifier)
        var constructionType:String =  tableData[indexPath.row]
        SwiftCoreDataHelper.addConstructionTypeToItem(item, constructionType: constructionType)
        if(constructionType == "Lanscape"){
            var subConstructionType = "Lanscape"
            SwiftCoreDataHelper.addSubConstructionTypeToItem(item, subConstructionType: subConstructionType)
        }
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
        
       override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let segueIdentifier =  segue.identifier{
            switch segueIdentifier{
            case "toMonument":
                var svc = segue.destinationViewController as MonumentViewController;
                svc.itemIdentifier = itemIdentifier
            case "toLocation":
                var svc = segue.destinationViewController as LocationViewController;
                svc.itemIdentifier = itemIdentifier
            case "toEdifice":
                var svc = segue.destinationViewController as EdificeViewController;
                svc.itemIdentifier = itemIdentifier
            default:
                var svc = segue.destinationViewController as LocationViewController;
                svc.itemIdentifier = itemIdentifier
        }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
