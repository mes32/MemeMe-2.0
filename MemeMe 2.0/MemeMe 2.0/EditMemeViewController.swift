//
//  ViewController.swift
//  MemeMe 2.0
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
    
    @IBOutlet weak var paddingTextFieldTop: NSLayoutConstraint!
    @IBOutlet weak var paddingTextFieldBottom: NSLayoutConstraint!
    
    // MARK: - Class attributes
    
    var topChromeHeight: CGFloat = 0.0
    var bottomChromeHeight: CGFloat = 0.0
    var sideChromeWidth: CGFloat = 0.0
    
    let paddingTextFieldTopDefault: CGFloat = 50.0
    let paddingTextFieldBottomDefault: CGFloat = 50.0
    
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
        
        imageView.configure(self, background: backgroundView, shareButton: shareButton)
        
        textFieldTop.setup(defaultText: startingTextTop, delegate: textFieldDelegate)
        textFieldBottom.setup(defaultText: startingTextBottom, delegate: textFieldDelegate)
        
        topChromeHeight = toolbarTop.frame.size.height + spacerView.frame.size.height
        bottomChromeHeight = toolbarBottom.frame.size.height
        sideChromeWidth = 1.0
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditMemeViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditMemeViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditMemeViewController.keyboardDidHide(_:)), name: UIKeyboardDidHideNotification, object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditMemeViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardDidHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        shareButton.enabled = false
        if (textFieldBottom.editing) {
            view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        setTextFieldPadding()
    }
    
    func keyboardWillHide(notification: NSNotification) {
        backgroundView.frame.origin.y = 0
    }
    
    func keyboardDidHide(notification: NSNotification) {
        shareButton.enabled = true
        setTextFieldPadding()
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
        
        imageView.image = nil
        backgroundView.backgroundColor = defaultBackgroundColor
        
        textFieldTop.reset()
        textFieldBottom.reset()
        setTextFieldPadding()
    }
    
    @IBAction func pressedShareButton(sender: AnyObject) {
        // Generate the memed-image
        let memedImage = generateMemedImage()
        
        // Share meme
        let items = [memedImage]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        // I got the following line from Stackoverflow: http://stackoverflow.com/questions/32930662/uiactivityviewcontroller-error-after-migration-to-swift-2
        avc.completionWithItemsHandler = { (s: String?, ok: Bool, items: [AnyObject]?, err:NSError?) -> Void in
            
            if (ok == true) {
                self.save(memedImage)
            }
            
        }
        avc.popoverPresentationController?.sourceView = sender as! UIView
        presentViewController(avc, animated: true, completion: nil)
    }
    
    
    func save(memedImage: UIImage) {
        //Create the meme and save the memed-image
        let meme = Meme( textTop: textFieldTop.text!, textBottom: textFieldBottom.text!, image: imageView.image, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        UIImageWriteToSavedPhotosAlbum(memedImage, nil, nil, nil)
    }
    
    // Generate the image with meme text
    // - START - from instructor notes
    func generateMemedImage() -> UIImage {
     
        hideOverlay()
        
        // Find offsets between the meme image and its ImageView
        let imageOffsets = imageView.getImageOffsets()
        
        // Partial screenshot code from Stackoverflow: http://stackoverflow.com/questions/35067354/how-do-i-take-a-partial-screenshot-save-to-cameraroll
        
        // Declare the snapshot boundaries
        let top: CGFloat = imageOffsets.y + topChromeHeight
        let bottom: CGFloat = imageOffsets.y + bottomChromeHeight
        let left: CGFloat = imageOffsets.x + sideChromeWidth
        let right: CGFloat = imageOffsets.x + sideChromeWidth
        
        // The size of the cropped image
        let size = CGSize(width: view.frame.size.width - left - right, height: view.frame.size.height - top - bottom)
        
        // Start the context
        UIGraphicsBeginImageContext(size)
        
        // we are going to use context in a couple of places
        let context = UIGraphicsGetCurrentContext()!
        
        // Transform the context so that anything drawn into it is displaced "top" pixels up
        // Something drawn at coordinate (0, 0) will now be drawn at (0, -top)
        // This will result in the "top" pixels being cut off
        // The bottom pixels are cut off because the size of the of the context
        CGContextTranslateCTM(context, -left, -top)
        
        // Draw the view into the context (this is the snapshot)
        view.layer.renderInContext(context)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context (this is required to not leak resources)
        UIGraphicsEndImageContext()
        
        // Save to photos
        UIImageWriteToSavedPhotosAlbum(memedImage, nil, nil, nil)
        
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
    
    func setTextFieldPadding() {
        if (imageView.image == nil) {
            paddingTextFieldTop.constant = paddingTextFieldTopDefault
            paddingTextFieldBottom.constant = paddingTextFieldBottomDefault
        } else {
            let imageOffsets = imageView.getImageOffsets()

            paddingTextFieldTop.constant = paddingTextFieldTopDefault + imageOffsets.y
            paddingTextFieldBottom.constant = paddingTextFieldBottomDefault + imageOffsets.y
        }
    }
    
    @IBAction func pressedCameraButton(sender: AnyObject) {
        imageView.getImageFromCamera(self)
    }
    
    @IBAction func pressedPhotoAlbumButton(sender: AnyObject) {
        imageView.getImageFromAlbum(self)
    }
    
    func rotated() {
        setTextFieldPadding()
     }
    
}

