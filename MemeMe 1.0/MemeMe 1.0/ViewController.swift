//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Michael Stockman on 9/4/16.
//  Copyright © 2016 Michael Stockman.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var textFieldTop: MemeTextField!
    @IBOutlet weak var textFieldBottom: MemeTextField!
    
    //var isEmptyTop: Bool = true
    //var isEmptyBottom: Bool = true
    
    let startingTextTop = "TOP TEXT"
    let startingTextBottom = "BOTTOM TEXT"
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        backgroundView.backgroundColor = UIColor.grayColor()
        
        imagePicker.delegate = self
        saveButton.enabled = false
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        textFieldTop.setup(defaultText: startingTextTop, delegate: self)
        textFieldBottom.setup(defaultText: startingTextBottom, delegate: self)
    }

    @IBAction func pressedSaveButton(sender: AnyObject) {
        print("Pressed save button")
    }
    
    @IBAction func pressedCameraButton(sender: AnyObject) {
        print("Pressed camera button")
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)    }
    
    @IBAction func pressedPhotoAlbumButton(sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Allow image picker to operate in landscape
    // http://stackoverflow.com/questions/33058691/use-uiimagepickercontroller-in-landscape-mode-in-swift-2-0
    /*extension UIImagePickerController {
        public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
            return .Landscape
        }
    }*/
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            backgroundView.backgroundColor = UIColor.blackColor()
            imageView.image = pickedImage
            imageView.sizeToFit()
            //imageView.sizeThatFits(<#T##size: CGSize##CGSize#>)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let memeTextField = textField as! MemeTextField
        if (!memeTextField.edited) {
            memeTextField.text = ""
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        let memeTextField = textField as! MemeTextField
        if (memeTextField.text == "" && memeTextField.edited) {
            memeTextField.reset()
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let memeTextField = textField as! MemeTextField
        memeTextField.edited = true
        
        // Convert typed text to uppercase
        // The following line of code is from Stackoverflow: http://stackoverflow.com/questions/21092182/uppercase-characters-in-uitextfield
        memeTextField.text = (memeTextField.text! as NSString).stringByReplacingCharactersInRange(range, withString:string.uppercaseString)
        
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func rotated() {
        // Respond to changes in device rotation
        // The following two if statements are from Stackoverflow: http://stackoverflow.com/questions/25666269/ios8-swift-how-to-detect-orientation-change
        
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            print(" - Landscape height = \(imageView.frame.height)")
        }
 
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation)) {
            print(" - Portrait height = \(imageView.frame.height)")
        }
    }
    
    // Keyboard notifications
    // - START - from instructor notes
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
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
        backgroundView.frame.origin.y -= getKeyboardHeight(notification)
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

}

