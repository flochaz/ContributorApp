//
//  ItemSummaryViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 11/5/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit

class ItemSummaryViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

        var itemIdentifier:String!
    
    
    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var smallImage: UIImageView!
    @IBOutlet weak var videoThumbnail: UIImageView!
    @IBOutlet weak var moreImage: UIImageView!
    
    @IBOutlet weak var builderTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
              // Do any additional setup after loading the view.
        loadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    

    func loadData(){
        if let item = SwiftCoreDataHelper.getItemFromIdentifier(itemIdentifier){
            builderTextField.text = item.builder
            
            if let dbImage = SwiftCoreDataHelper.getRandomImageFromItem(item){
                println("FOUND IMAGE \(dbImage.url) in ITEM \(itemIdentifier)")
                largeImage.image = UIImage(data: dbImage.imageData)
                smallImage.image = UIImage(data: SwiftCoreDataHelper.getRandomImageFromItem(item)!.imageData)
            }
        }

    }
    
    @IBAction func chooseImage(sender: AnyObject) {
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!) {
        
        var imageUrl = info.objectForKey(UIImagePickerControllerReferenceURL) as NSURL?
        
        
        var pickedImage = info.objectForKey(UIImagePickerControllerOriginalImage) as? UIImage
        var imageInfo = info
        largeImage.image = pickedImage
        
        if let image: Image = SwiftCoreDataHelper.getImageFromIdentifier(SwiftCoreDataHelper.createImage(imageUrl!, imageData: UIImagePNGRepresentation(pickedImage))){
            SwiftCoreDataHelper.addImageToItem(SwiftCoreDataHelper.getItemFromIdentifier(itemIdentifier)!, image:image)
            largeImage.image = pickedImage
        } else{
            let alert = UIAlertController(title: "Image already assigned", message: "This Image has already been assign to another item, choose another image", preferredStyle: UIAlertControllerStyle.Alert)
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // Refactoring the code to get location seems to not be working so keeping it inside the image picker for the moment : need investigation
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        itemIdentifier = ""
    }


}
