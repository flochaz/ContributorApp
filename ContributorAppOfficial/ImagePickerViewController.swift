//
//  ImagePickerViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/1/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//
import UIKit


class ImagePickerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var pickedImage: UIImage?
    var imageInfo: NSDictionary?
    var imageUrl: NSURL?
    var itemIdentifier:String = ""

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
    
    
    func initiateItemWithImage(sender: AnyObject) {
        println("Save Image")
     itemIdentifier = SwiftCoreDataHelper.createItem(imageUrl)
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        initiateItemWithImage(self);
        var svc = segue.destinationViewController as ConstructionViewController;
        
        if(!itemIdentifier.isEmpty){
        svc.itemIdentifier = itemIdentifier
        }else{
                    svc.itemIdentifier = "NO IDENTIFIER"
        }

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
