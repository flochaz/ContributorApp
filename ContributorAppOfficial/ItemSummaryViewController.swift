//
//  ItemSummaryViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 11/5/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit

class ItemSummaryViewController: UIViewController {

        var itemIdentifier:String!
    
    
    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var smallImage: UIImageView!
    @IBOutlet weak var videoThumbnail: UIImageView!
    @IBOutlet weak var moreImage: UIImageView!
    
    @IBOutlet weak var builderTextField: UITextField!

    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
              // Do any additional setup after loading the view.
        loadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("UPDATE IMAGE")
        
    }
    
    @IBAction func tryUpdate(sender: AnyObject) {
        loadData()
        largeImage.image = image
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
