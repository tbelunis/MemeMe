//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by TOM BELUNIS on 4/27/15.
//  Copyright (c) 2015 TOM BELUNIS. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Set the text attributes for the top and bottom text fields
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
            NSStrokeWidthAttributeName : -5
        ]
        
        // Set the attributes for topTextField
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
    
        // This class will implement the UITextFieldDelegate protocol
        topTextField.delegate = self
        
        // Add a target to topTextField to handle the EditingChanged events
        topTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        // Set the attributes for bottomTextField
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        // This class will implement the UITextFieldDelegate protocol
        bottomTextField.delegate = self
        
        // Add a target to bottomTextField to handle the EditingChanged events
        bottomTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        
        // Enable the button for the camera only if the camera is available
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Generate the memed image
    func generateMemedImage() -> UIImage {
        // Hide the toolbars
        navigationBar.hidden = true
        toolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Unhide the toolbars
        toolBar.hidden = false
        navigationBar.hidden = false
        
        return memedImage
    }
    
    // Handle the EditingChanged events for the textField and
    // always return the upper case value of the text property
    func textFieldDidChange(textField: UITextField) {
        textField.text = textField.text.uppercaseString
    }
    
    // Subscribe to the notifications for showing and hiding the keyboard
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // Unsubscribe from keyboard notifications
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // Return the height of the keyboard
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // If we are editing the bottomTextField, move the view up by
    // the height of the keyboard so that the text field stays in view
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    // If we are editing the bottomTextField, move the view down by
    // the height of the keyboard when the keyboard is being hidden
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clean up by unsubscribing from the keyboard notifications
        self.unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: IBActions
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Share the meme with the UIActivityViewController
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        
        // Generate the memed image and create a new meme
        let memedImage = generateMemedImage()
        var meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
        
        // Save the new meme in the array in the AppDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.append(meme)
        
        // Pass the memedImage to the UIActivityViewController
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        var shareError: NSError?
        
        // Set the completion handler to dismiss the MemeEditorViewController when
        // UIActivityViewController has completed its work
        controller.completionWithItemsHandler = {(activityType, completed, returnedItems, error) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        // Show the UIActivityViewController
        self.presentViewController(controller, animated: true) {
        }
    }
    
    @IBAction func cancelEditor(sender: UIBarButtonItem) {
        // User has cancelled editing the meme, so reset the image and text fields
        imageView.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareButton.enabled = false
        
        // Check to see if there are any sent memes. Don't present the table view
        // if there are no sent memes
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if appDelegate.memes.count == 0 {
            let controller = UIAlertController(title: "No Sent Memes", message: "You haven't sent any memes yet.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Create a Meme", style: UIAlertActionStyle.Default, handler: nil)
            controller.addAction(okAction)
            self.presentViewController(controller, animated: true, completion: nil)
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    
}
// MARK: UIImagePickerControllerDelegate methods
extension MemeEditorViewController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            self.shareButton.enabled = true
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

// MARK: UINavigationControllerDelegate methods
// No need to implement any functions, but we must implement the
// UINavigationControllerDelegate protocol for the UIImagePickerController
extension MemeEditorViewController: UINavigationControllerDelegate {
    
}

// MARK: UITextFieldDelegate methods
extension MemeEditorViewController: UITextFieldDelegate {    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
