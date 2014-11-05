//
//  SwiftCoreDataHelper.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 11/4/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class SwiftCoreDataHelper: NSObject {

    class func createItem(imageUrl: NSURL?) ->  String {
    var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    var context:NSManagedObjectContext = appDelegate.managedObjectContext!
    var item:Item!
    
    item  = NSEntityDescription.insertNewObjectForEntityForName(NSStringFromClass(Item), inManagedObjectContext: context) as Item
    item.identifier = NSUUID().UUIDString
    println("item identifier : " + item.identifier)
    
    if let url:NSURL = imageUrl {
    var  image:Image  = NSEntityDescription.insertNewObjectForEntityForName(NSStringFromClass(Image), inManagedObjectContext: context) as Image
    
        image.url =  url.absoluteString!
        //TODO : figure out if we really need to store the image data
       // image.imageData = UIImagePNGRepresentation(pickedImage)
        if let location:CLLocation = ImageManagementHelper.getPhotoLocationCoordinateFromUrl(url) {
            image.latitude = location.coordinate.latitude
            image.longitude = location.coordinate.longitude
            //INFO: Set default (not accurate) item location
            item.latitude = location.coordinate.latitude
            item.longitude = location.coordinate.longitude
        }
        image.item = item
    }
    //TODO: Manage save error
    context.save(nil)
    println("Entry Saved")
    return item.identifier
    }
    
    class func getItemFromIdentifier(itemId:String) -> Item {
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
            println("No item with id " + itemId + " found in DB!")
        }
        return item
    }

    class func addConstructionTypeToItem(item: Item, constructionType: String){
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        item.constructionType = constructionType
        context.save(nil)
    }
    
    class func addSubConstructionTypeToItem(item: Item, subConstructionType: String){
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        item.subConstructionType = subConstructionType
        context.save(nil)
    }
}
