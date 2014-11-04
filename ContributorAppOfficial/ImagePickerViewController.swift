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
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var pickedImage: UIImage?
    var imageInfo: NSDictionary?
    var assetLib = ALAssetsLibrary()
    var imageUrl: NSURL?
    var item:Item!

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    @IBAction func chooseImage(sender: AnyObject) {
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!) {
        
        imageUrl = info.objectForKey(UIImagePickerControllerReferenceURL) as NSURL?
        
        
        pickedImage = info.objectForKey(UIImagePickerControllerOriginalImage) as? UIImage
        imageInfo = info
        imageView.image = pickedImage
        doneButton.enabled = true
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // Refactoring the code to get location seems to not be working so keeping it inside the image picker for the moment : need investigation
        
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveImage(sender: AnyObject) {
        println("Save Image")
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        item  = NSEntityDescription.insertNewObjectForEntityForName(NSStringFromClass(Item), inManagedObjectContext: context) as Item
        item.identifier = NSUUID().UUIDString
        println("item identifier : " + item.identifier)
        
        
        var  image:Image  = NSEntityDescription.insertNewObjectForEntityForName(NSStringFromClass(Image), inManagedObjectContext: context) as Image
        if let url:NSURL = self.imageUrl {
        image.url =  url.absoluteString!
        image.imageData = UIImagePNGRepresentation(pickedImage)
            if let location:CLLocation = ImageManagementHelper.getPhotoLocationCoordinateFromUrl(url) {
            image.latitude = location.coordinate.latitude
            image.longitude = location.coordinate.longitude
            // Set default (not accurate) item location
            item.latitude = location.coordinate.latitude
            item.longitude = location.coordinate.longitude
        }
        image.item = item
        }
        
        context.save(nil)
        println("Entry Saved")
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        saveImage(self);
        var svc = segue.destinationViewController as ConstructionViewController;
        
        if(!item.identifier.isEmpty){
        svc.itemIndetifier = item.identifier
        }else{
                    svc.itemIndetifier = "NO IDENTIFIER"
        }

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
