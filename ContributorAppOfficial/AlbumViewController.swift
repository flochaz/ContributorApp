//
//  AlbumViewController.swift
//  UICollectionView+Swift
//
//  Created by Mobmaxime on 14/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class AlbumViewController: UICollectionViewController {
    
    var items:NSMutableArray = NSMutableArray()
    var itemIdentifier:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        items.removeAllObjects()
        
        
        let results:NSArray = SwiftCoreDataHelper.getAllItems()
        
        for item in results{
            let singleItem:Item = item as Item
            if let randomImage = SwiftCoreDataHelper.getRandomImageFromItem(singleItem){
                var randomImageData:NSData = randomImage.imageData
                let itemDict:NSDictionary = ["identifier":singleItem.identifier,"itemName":singleItem.name,"itemImageData":randomImageData]
                
                items.addObject(itemDict)
            }
            
        }

    }
    
    /*
    // #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    // #pragma mark UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView?) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        /*
        We can use multiple way to create a UICollectionViewCell.
        */
        
        
        //1.
        //We can use Reusablecell identifier with custom UICollectionViewCell
        
        /*
        let cell = collectionView!.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        
        var AlbumImage : UIImageView = cell.viewWithTag(100) as UIImageView
        AlbumImage.image = UIImage(named: Albums[indexPath.row])
        */
        
        
        
        //2.
        //You can create a Class file for UICollectionViewCell and Set the appropriate component and assign the value to that class
        
        let cell : AlbumCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as AlbumCell
        cell.backgroundView = UIImageView(image: UIImage(named: "photo-frame.png")) as UIView
        let itemDict:NSDictionary = items.objectAtIndex(indexPath.row) as NSDictionary
        
        let itemName = itemDict.objectForKey("itemName") as String
        let imageData:NSData = itemDict.objectForKey("itemImageData") as NSData
        
        let itemImage = UIImage(data: imageData)
        
        cell.AlbumImage?.image = itemImage
        cell.itemName?.text = itemName
        //cell.itemName?.text = itemName
        return cell
    }
    
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.destinationViewController is ItemSummaryViewController{
            let indexPath: NSIndexPath = self.collectionView.indexPathForCell(sender as UICollectionViewCell)!
            let itemDict:NSDictionary = items.objectAtIndex(indexPath.row) as NSDictionary
            println("itemChoosen")
            itemIdentifier = itemDict.objectForKey("identifier") as String

            var svc = segue.destinationViewController as ItemSummaryViewController;
            svc.itemIdentifier = itemIdentifier
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
