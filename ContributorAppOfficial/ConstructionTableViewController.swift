//
//  ConstructionTableViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/13/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit
import CoreData

class ConstructionTableViewController: UITableViewController {

    var itemIndetifier:String!
    var item:Item!
   // var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
   // var context:NSManagedObjectContext!
    var tableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableData.append("Monument");
        self.tableData.append("Edifice");
        self.tableData.append("Landscape");

        
        if(!itemIndetifier.isEmpty){
        println("From table view Test variable transfer : " + itemIndetifier)
        }else{
            println("From table  test variable Not setted")
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let alert = UIAlertController(title: "Item selected", message: "You selected item \(indexPath.row)", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: {
                (alert: UIAlertAction!) in println("An alert of type \(alert.style.hashValue) was tapped!")
        }))
        self.item = getItem(self.itemIndetifier)
        var constructionType:NSString =  tableData[indexPath.row]
        addConstructionTypeToItem(item, constructionType: constructionType)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    func addConstructionTypeToItem(item: Item, constructionType: NSString){
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        item.desc = constructionType
        context.save(nil)
    }
    
    func getItem(itemId:String) -> Item {
        var item:Item!
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Item")
        request.returnsObjectsAsFaults = false;
        println("search for item with identifier " + itemId)
        //request.predicate = NSPredicate(format: "identifier = %@",itemId)
        var results: NSArray = context.executeFetchRequest(request,error: nil)!
        if (results.count > 0){
            for result in results{
                item = result as Item
                println("FOUND THE ITEM")
            }
        }
        else{
            println("No item with id " + itemIndetifier + " found in DB!")
        }
        return item
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var svc = segue.destinationViewController as MonumentViewController;
        if(!itemIndetifier.isEmpty){
            svc.itemIndetifier = itemIndetifier
        }else{
            svc.itemIndetifier = "NO IDENTIFIER"
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
