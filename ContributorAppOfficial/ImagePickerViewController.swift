//
//  ImagePickerViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/1/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//
import CoreData
import UIKit
import AssetsLibrary
import CoreLocation

class ImagePickerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    
    var pickedImage: UIImage!
    var imageInfo: NSDictionary!
    var assetLib = ALAssetsLibrary()
    var url: NSURL = NSURL()
    var  location: CLLocation!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func saveImage(sender: AnyObject) {
        println("Save Image")
      var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
      var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var  image:Image  = NSEntityDescription.insertNewObjectForEntityForName(NSStringFromClass(Image), inManagedObjectContext: context) as Image
        
        image.url =  url.absoluteString!
        image.imageData = UIImagePNGRepresentation(pickedImage)
        if (location != nil) {
            image.latitude = location.coordinate.latitude
            image.longitude = location.coordinate.longitude
        }
        
        context.save(nil)
        println("Entry Saved")
    }
    
    @IBAction func chooseImage(sender: AnyObject) {
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!) {
        
        url = info.objectForKey(UIImagePickerControllerReferenceURL) as NSURL
        assetLib.assetForURL(url, resultBlock: {
            (asset: ALAsset!) in
            if asset != nil {
                var assetRep: ALAssetRepresentation = asset.defaultRepresentation()
                var iref = assetRep.fullResolutionImage().takeUnretainedValue()
                var image =  UIImage(CGImage: iref)
                self.location = asset.valueForProperty(ALAssetPropertyLocation) as CLLocation
                println("Image Location")
                println(self.location)
                
            }
            }, failureBlock: {
                (error: NSError!) in
                
                NSLog("Error!")
            }
        )

        
        pickedImage = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        imageInfo = info
        println(info)
        println(info.objectForKey(UIImagePickerControllerMediaMetadata))
        imageView.image = pickedImage
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // Refactoring the code to get location seems to not be working so keeping it inside the image picker for the moment : need investigation
    func  getPhotoLocationCoordinateFromUrl(url: NSURL) -> CLLocationCoordinate2D! {
        
        var coordinate: CLLocationCoordinate2D!
        assetLib.assetForURL(url, resultBlock: {
            (asset: ALAsset!) in
            if asset != nil {
                var assetRep: ALAssetRepresentation = asset.defaultRepresentation()
                var iref = assetRep.fullResolutionImage().takeUnretainedValue()
                var image =  UIImage(CGImage: iref)
                coordinate = (asset.valueForProperty(ALAssetPropertyLocation) as CLLocation).coordinate
                println("Image Location")
                println(coordinate)
                
            }
            }, failureBlock: {
                (error: NSError!) in
                
                NSLog("Error!")
            }
        )
        return coordinate
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
