//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Michael Stockman on 9/4/16.
//  Copyright © 2016 Michael Stockman.
//

import UIKit

class EditMemeViewController: UIViewController {
    
    // MARK: - Outlets from storyboard
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var imageView: MemeImageView!
    @IBOutlet weak var spacerView: UIView!
    @IBOutlet weak var toolbarTop: UIToolbar!
    @IBOutlet weak var toolbarBottom: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var textFieldTop: MemeTextField!
    @IBOutlet weak var textFieldBottom: MemeTextField!
    
    // MARK: - Class attributes
    
    let startingTextTop = "TOP TEXT"
    let startingTextBottom = "BOTTOM TEXT"
    let defaultBackgroundColor = UIColor.grayColor()
    
    let textFieldDelegate = MemeTextFieldDelegate()
    let imagePicker = UIImagePickerController()

    // MARK: - Class methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.enabled = false
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        imageView.configure(backgroundView, shareButton: shareButton)
        
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
    
    // Implement responses to keyboard notifications.
    // Allows the view can move up to accomodate keyboard.
    // - START - from instructor notes
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditMemeViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditMemeViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if (textFieldBottom.editing) {
            view.frame.origin.y = getKeyboardHeight(notification) * -1
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
    
    // MARK: - Actions from storyboard and helper functions

    @IBAction func pressedCancelButton(sender: AnyObject) {
        shareButton.enabled = false
        
        textFieldTop.reset()
        textFieldBottom.reset()
        
        imageView.image = nil
        backgroundView.backgroundColor = defaultBackgroundColor
    }
    
    @IBAction func pressedShareButton(sender: AnyObject) {
        // Generate the memed-image
        let memedImage = generateMemedImage()
        
        // Share meme
        let items = [memedImage]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        // I got the following line from Stackoverflow: http://stackoverflow.com/questions/32930662/uiactivityviewcontroller-error-after-migration-to-swift-2
        avc.completionWithItemsHandler = { (s: String?, ok: Bool, items: [AnyObject]?, err:NSError?) -> Void in }
        avc.popoverPresentationController?.sourceView = sender as! UIView
        presentViewController(avc, animated: true, completion: { self.save(memedImage) })
    }
    
    
    func save(memedImage: UIImage) {
        //Create the meme and save the memed-image
        // TODO: Meme needs to take MemeTextFields and handle properly if they are unedited
        let meme = Meme( textTop: textFieldTop.text!, textBottom: textFieldBottom.text!, image: imageView.image, memedImage: memedImage)
        
        UIImageWriteToSavedPhotosAlbum(memedImage, nil, nil, nil)
    }
    
    // Generate the image with meme text
    // - START - from instructor notes
    func generateMemedImage() -> UIImage {
     
        hideOverlay()
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO: Only select the image instead of the whole screen
        // Note: This requires that meme text is moved such that it is always above the image
        /*let imageRect = getImageRect()
        UIGraphicsBeginImageContext(imageRect.size)
        view.drawViewHierarchyInRect(imageRect, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()*/
     
        showOverlay()
     
        return memedImage
     }
    // - STOP - from instructor notes
    
    func hideOverlay() {
        spacerView.hidden = true
        toolbarTop.hidden = true
        toolbarBottom.hidden = true
        if (!textFieldTop.edited) {
            textFieldTop.hidden = true
        }
        if (!textFieldBottom.edited) {
            textFieldBottom.hidden = true
        }
    }
    
    func showOverlay() {
        spacerView.hidden = false
        toolbarTop.hidden = false
        toolbarBottom.hidden = false
        textFieldTop.hidden = false
        textFieldBottom.hidden = false
    }
    
    @IBAction func pressedCameraButton(sender: AnyObject) {
        imageView.getImageFromCamera(self)
    }
    
    @IBAction func pressedPhotoAlbumButton(sender: AnyObject) {
        imageView.getImageFromAlbum(self)
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
    
    // TODO: Animate changes to constraints
    // The following is from Stackoverflow: http://stackoverflow.com/questions/28127259/how-to-update-the-constant-of-a-constraint-programmatically-in-swift
    /*self.view.layoutIfNeeded()
        UIView.animateWithDuration(1, animations: {
        self.sampleConstraint.constant = 20
        self.view.layoutIfNeeded()
    })*/
    
}

