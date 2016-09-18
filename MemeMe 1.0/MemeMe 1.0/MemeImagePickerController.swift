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
    
    // MARK: - Define class attributes
    
    var imageView: MemeImageView!
    
    // MARK: - Define class method
    
    func configure(imageView: MemeImageView) {
        self.imageView = imageView
        self.delegate = self
    }
    
    func setImage(viewController: EditMemeViewController, sourceType: UIImagePickerControllerSourceType) {
        self.sourceType = sourceType
        viewController.presentViewController(self, animated: true, completion: nil)
    }
    
    // MARK: - Define class methods inherited from UIImagePickerController
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                imageView.pickImage(pickedImage)
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}