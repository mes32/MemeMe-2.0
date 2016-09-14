//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Michael Stockman on 9/4/16.
//  Copyright © 2016 Michael Stockman.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spacerView: UIView!
    @IBOutlet weak var toolbarTop: UIToolbar!
    @IBOutlet weak var toolbarBottom: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var textFieldTop: MemeTextField!
    @IBOutlet weak var textFieldBottom: MemeTextField!
    
    let startingTextTop = "TOP TEXT"
    let startingTextBottom = "BOTTOM TEXT"
    
    let textFieldDelegate = MemeTextFieldDelegate()
    let imagePicker = UIImagePickerController()
    
    struct Meme {
        var textTop: String
        var textBottom: String
        var image: UIImage!
        var memedImage: UIImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        backgroundView.backgroundColor = UIColor.grayColor()
        
        imagePicker.delegate = self
        shareButton.enabled = false
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        textFieldTop.setup(defaultText: startingTextTop, delegate: textFieldDelegate)
        textFieldBottom.setup(defaultText: startingTextBottom, delegate: textFieldDelegate)
    }
    
    // Subscribe to keyboard notifications
    // - START - from instructor notes
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    // - STOP - from instructor notes
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            backgroundView.backgroundColor = UIColor.blackColor()
            imageView.image = pickedImage
            imageView.sizeToFit()
            shareButton.enabled = true
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Implement subscribe to keyboard notifications so that the view can move up to accomodate keyboard
    // - START - from instructor notes
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if (textFieldBottom.editing) {
            backgroundView.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        backgroundView.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    // - STOP - from instructor notes

    @IBAction func pressedShareButton(sender: AnyObject) {
        // Generate memed image
        let memedImage = generateMemedImage()
        
        //Create the meme
        let meme = Meme( textTop: textFieldTop.text!, textBottom: textFieldBottom.text!, image: imageView.image, memedImage: memedImage)
        
        // Share the meme
    }
    
    // Generate the image with meme text
    // - START - from instructor notes
    func generateMemedImage() -> UIImage {
     
        hideToolbars()
     
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
     
        showToolbars()
     
        return memedImage
     }
    // - STOP - from instructor notes
    
    func hideToolbars() {
        spacerView.hidden = true
        toolbarTop.hidden = true
        toolbarBottom.hidden = true
    }
    
    func showToolbars() {
        spacerView.hidden = false
        toolbarTop.hidden = false
        toolbarBottom.hidden = false
    }
    
    // Share the meme
    /*func shareMeme() {
        
    }*/
    
    @IBAction func pressedCameraButton(sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)    }
    
    @IBAction func pressedPhotoAlbumButton(sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // TODO: Allow image picker to operate in landscape or portrait
    // http://stackoverflow.com/questions/33058691/use-uiimagepickercontroller-in-landscape-mode-in-swift-2-0
    /*extension UIImagePickerController {
     public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
     return [.Landscape, .Portrait]
     }
     }*/
    
    // TODO: Respond to changes in device orientation
    // The following is from Stackoverflow: http://stackoverflow.com/questions/25666269/ios8-swift-how-to-detect-orientation-change
    /*func rotated() {
     // Subscribe to observer in viewWillAppear() - NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
     
     if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
     print(" - Landscape height = \(imageView.frame.height)")
     }
     
     if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation)) {
     print(" - Portrait height = \(imageView.frame.height)")
     }
     }*/
    
}

