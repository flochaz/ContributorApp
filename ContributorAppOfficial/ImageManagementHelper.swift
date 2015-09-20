//
//  ImageManagementHelper.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 11/4/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit
import CoreLocation
import AssetsLibrary


class ImageManagementHelper: NSObject {
   
    class func  getPhotoLocationCoordinateFromUrl(url: NSURL) -> CLLocation? {
        
        var location: CLLocation?
        ALAssetsLibrary().assetForURL(url, resultBlock: {
            (asset: ALAsset!) in
            if asset != nil {
                var assetRep: ALAssetRepresentation = asset.defaultRepresentation()
                var iref = assetRep.fullResolutionImage().takeUnretainedValue()
                var image =  UIImage(CGImage: iref)
                if(asset.valueForProperty(ALAssetPropertyLocation) != nil){
                    location = (asset.valueForProperty(ALAssetPropertyLocation) as? CLLocation?)!
                    println("Image Location")
                    println(location)
                }else
                {
                    println("Image with no location")
                }
                
            }
            }, failureBlock: {
                (error: NSError!) in
                
                NSLog("Error!")
            }
        )
        return location
    }
    
    class func  getPhotoFromUrl(url: NSURL) -> UIImage? {
        
        var image: UIImage?
        ALAssetsLibrary().assetForURL(url, resultBlock: {
            (asset: ALAsset!) in
            if asset != nil {
                var assetRep: ALAssetRepresentation = asset.defaultRepresentation()
                var iref = assetRep.fullResolutionImage().takeUnretainedValue()
                image =  UIImage(CGImage: iref)
                println("FOUND image from \(url) \(image)")
            }else{
                println("IMAGE NOT FOUND")
            }
            }, failureBlock: {
                (error: NSError!) in
                
                NSLog("Error!")
            }
        )
        return image
    }
    
    func scaleImageWith(image:UIImage, newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}
