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
  
  var meme: Meme?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    let memeTextAttributes = [
      NSStrokeColorAttributeName : UIColor.blackColor(),
      NSForegroundColorAttributeName : UIColor.whiteColor(),
      NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
      NSStrokeWidthAttributeName : -5
    ]
    
    topTextField.defaultTextAttributes = memeTextAttributes
    topTextField.textAlignment = NSTextAlignment.Center
    topTextField.delegate = self
    topTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    
    bottomTextField.defaultTextAttributes = memeTextAttributes
    bottomTextField.textAlignment = NSTextAlignment.Center
    bottomTextField.delegate = self
    bottomTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)

  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.subscribeToKeyboardNotifications()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // TODO: Generate the memed image
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
  
  func textFieldDidChange(textField: UITextField) {
    textField.text = textField.text.uppercaseString
  }
  
  func subscribeToKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
  }

  func unsubscribeFromKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
    return keyboardSize.CGRectValue().height
  }
  
  func keyboardWillShow(notification: NSNotification) {
    if bottomTextField.isFirstResponder() {
      self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
  }
  
  func keyboardWillHide(notification: NSNotification) {
    if bottomTextField.isFirstResponder() {
      self.view.frame.origin.y += getKeyboardHeight(notification)
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
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
  
  @IBAction func shareMeme(sender: UIBarButtonItem) {
    var meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    appDelegate.memes.append(meme)
    
    
    self.dismissViewControllerAnimated(true, completion: nil)
    
  }
  
  @IBAction func cancelEditor(sender: UIBarButtonItem) {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  
  
}
// MARK: UIImagePickerControllerDelegate methods
extension MemeEditorViewController: UIImagePickerControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      imageView.image = image
      self.dismissViewControllerAnimated(true, completion: nil)
    }
  }
}

// MARK: UINavigationControllerDelegate methods
extension MemeEditorViewController: UINavigationControllerDelegate {
  
}

// MARK: UITextFieldDelegate methods
extension MemeEditorViewController: UITextFieldDelegate {
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//    textField.text = textField.text.uppercaseString
    return true
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
