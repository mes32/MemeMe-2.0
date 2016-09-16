//
//  MemeImagePickerController.swift
//  MemeMe 1.0
//
//  Created by Michael Stockman on 9/15/16.
//  Copyright © 2016 Michael Stockman.
//

import Foundation
import UIKit

class MemeImagePickerController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var backgroundView: UIView!
    var shareButton: UIBarButtonItem!
    var imagePicker: UIImagePickerController!
    
    func configure(background: UIView, shareButton: UIBarButtonItem) {
        /*self.backgroundView = background
        
        self.backgroundView.backgroundColor = defaultBackgroundColor
        
        self.shareButton = shareButton
        self.imagePicker = UIImagePickerController()
        
        self.imagePicker!.delegate = self*/
    }
    
    func setImageFromCamera(viewController: ViewController) {
        /*self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        viewController.presentViewController(imagePicker, animated: true, completion: nil)*/
    }
    
    func setImageFromAlbum(viewController: ViewController) {
        /*imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        viewController.presentViewController(imagePicker, animated: true, completion: nil)*/
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        /*if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            backgroundView!.backgroundColor = chosenBackgroundColor
            self.image = pickedImage
            self.sizeToFit()
            shareButton!.enabled = true
        }
        
        self.imagePicker!.dismissViewControllerAnimated(true, completion: nil)*/
    }
    
    func imagePickerControllerDidCancel() {
        //self.imagePicker!.dismissViewControllerAnimated(true, completion: nil)
    }
}