//
//  AddInfoViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/1/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit

class AddInfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var builderTextField: UITextField!
    @IBOutlet weak var buildDate: UIDatePicker!
    @IBOutlet weak var whyTextField: UITextView!
    var itemIdentifier:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        builderTextField.delegate = self
        //buildDate.delegate = self
        whyTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldReturn(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    /**
    * Called when the user click on the view (outside the UITextField).
    */
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        SwiftCoreDataHelper.updateItemDescription(SwiftCoreDataHelper.getItemFromIdentifier(itemIdentifier)!, itemName:nameTextField.text, itemBuilder:builderTextField.text, itemStartBuildDate:buildDate.date, itemEndBuildDate:buildDate.date, itemWhyBuild:whyTextField.text)
        if segue.destinationViewController is ItemSummaryViewController{
            var svc = segue.destinationViewController as ItemSummaryViewController;
            
            svc.itemIdentifier = itemIdentifier
        }
    }


}
