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
        // I grabbed this line from Stackoverflow: http://stackoverflow.com/questions/21092182/uppercase-characters-in-uitextfield
        memeTextField.text = (memeTextField.text! as NSString).stringByReplacingCharactersInRange(range, withString:string.uppercaseString)
        
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

