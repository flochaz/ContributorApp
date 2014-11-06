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
    
    
    class func createImage(imageUrl: NSURL, imageData:NSData) -> String{
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        if (!imageAlreadyExist(imageUrl.absoluteString!)){
            println("create new Image \(imageUrl.absoluteString)")
            var image:Image = NSEntityDescription.insertNewObjectForEntityForName(NSStringFromClass(Image), inManagedObjectContext: context) as Image
            image.imageData = imageData
            image.url =  imageUrl.absoluteString!
            if let location:CLLocation = ImageManagementHelper.getPhotoLocationCoordinateFromUrl(imageUrl) {
                image.latitude = location.coordinate.latitude
                image.longitude = location.coordinate.longitude
            }
        }else{
            println("Image already exist")
        }
        
        return imageUrl.absoluteString!
    }
    
    class func imageAlreadyExist(id:String) -> Bool{
        var imageAlreadyExist:Bool = false
        if let imageWithId:Image = getImageFromIdentifier(id){
            imageAlreadyExist = true
        }
        return imageAlreadyExist
    }
    
    class func getImageFromIdentifier(imageUrl:String) -> Image?{
        var image:Image?
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Image")
        request.returnsObjectsAsFaults = false;
        request.predicate = NSPredicate(format: "url = %@",imageUrl)
        var results: NSArray = context.executeFetchRequest(request,error: nil)!
        if (results.count == 1){
            image = results[0] as? Image
        }
        else{
            println("Image serch return \(results.count) results")
        }
        return image
    }
    
    class func addImageToItem(item:Item, image:Image) {
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        image.item = item
        //TODO: Manage save error
        context.save(nil)
        println("Entry Saved")
    }
    
    
    
    class func createItem() ->  String {
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        var item:Item!
        
        item  = NSEntityDescription.insertNewObjectForEntityForName(NSStringFromClass(Item), inManagedObjectContext: context) as Item
        item.identifier = NSUUID().UUIDString
        println("item identifier : " + item.identifier)
        //TODO: Manage save error
        context.save(nil)
        item.objectID
        println("Entry Saved")
        return item.identifier
    }
    
    class func getItemFromIdentifier(itemId:String) -> Item? {
        var item:Item?
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Item")
        request.returnsObjectsAsFaults = false;
        println("search for item with identifier " + itemId)
        request.predicate = NSPredicate(format: "identifier = %@",itemId)
        var results: NSArray = context.executeFetchRequest(request,error: nil)!
        if (results.count > 0){
            for result in results{
                item = result as? Item
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
    
    class func addLocationToItem(item:Item, latitude:Double, longitude:Double){
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        item.latitude = latitude
        item.longitude = longitude
        context.save(nil)
    }
    
    
    class func updateItemDescription(item:Item, itemName:String, itemBuilder:String, itemStartBuildDate:NSDate, itemEndBuildDate:NSDate, itemWhyBuild:String){
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        item.name = itemName
        item.builder = itemBuilder
        item.startBuildDate = itemStartBuildDate
        item.endBuildDate = itemEndBuildDate
        item.whyBuild = itemWhyBuild
        context.save(nil)
    }
    
    class func getRandomImageFromItem(item:Item) -> Image?{
        let image = item.image.anyObject() as Image?
        return image
    }
    
}
