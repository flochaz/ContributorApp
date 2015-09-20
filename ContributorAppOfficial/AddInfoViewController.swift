//
//  AddInfoViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 10/1/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit

class AddInfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var slidingView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var builderTextField: UITextField!
    @IBOutlet weak var whyTextField: UITextView!
    var itemIdentifier:String!
    @IBOutlet weak var buildDate: UITextField!

    @IBOutlet var topConstraint : NSLayoutConstraint!
    @IBOutlet var bottomConstraint : NSLayoutConstraint!
    var fr : UIView?
    var buildDateDate: NSDate!
    var datePickerView  : UIDatePicker = UIDatePicker()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        builderTextField.delegate = self
        whyTextField.delegate = self
        buildDate.delegate = self
        datePickerView.datePickerMode = UIDatePickerMode.Date
        buildDate.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)

        // Do any additional setup after loading the view.
        registerForKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldDidBeginEditing(tf: UITextField) {
        self.fr = tf // keep track of first responder
    }
    
    func textViewDidBeginEditing(tv: UITextView) {
        self.fr = tv // keep track of first responder
    }

    func textViewShouldReturn(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }


    
    //MARK: - Keyboard Management Methods
    
    // Call this method somewhere in your view controller setup code.
    func registerForKeyboardNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeShown:",
            name: UIKeyboardDidShowNotification,
            object: nil)
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeHidden:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    // Called when the UIKeyboardDidShowNotification is sent.
    func keyboardWillBeShown(n: NSNotification) {
        let d = n.userInfo!
        var r = (d[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        // in iOS 8, keyboard and fullscreen views are in same coordinate space
        // however, I'm keeping this line because our view might not be fullscreen
        r = self.slidingView.convertRect(r, fromView:nil)
        let f = self.fr!.frame
        let y : CGFloat =
        f.maxY + r.size.height - self.slidingView.bounds.height + 5
        if r.origin.y < f.maxY {
            self.topConstraint.constant = -y
            self.bottomConstraint.constant = y
            self.view.layoutIfNeeded()

        }
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    func keyboardWillBeHidden(sender: NSNotification) {
        self.topConstraint.constant = 0
        self.bottomConstraint.constant = 0
        self.view.layoutIfNeeded()    }
    


    func updateTextField(sender: UITextField){
        if(buildDate.isFirstResponder()){
            var datePickerView  : UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.Date
            sender.inputView = datePickerView
            datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        }
    }
      func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        buildDate.text = dateFormatter.stringFromDate(sender.date)
        buildDateDate = sender.date
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        SwiftCoreDataHelper.updateItemDescription(SwiftCoreDataHelper.getItemFromIdentifier(itemIdentifier)!, itemName:nameTextField.text, itemBuilder:builderTextField.text, itemStartBuildDate:buildDateDate, itemEndBuildDate:buildDateDate, itemWhyBuild:whyTextField.text)
        if segue.destinationViewController is ItemSummaryViewController{
            var svc = segue.destinationViewController as! ItemSummaryViewController;
            
            svc.itemIdentifier = itemIdentifier
        }
    }


}
