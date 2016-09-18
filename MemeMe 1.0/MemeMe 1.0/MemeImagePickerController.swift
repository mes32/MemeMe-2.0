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
    
    var memeImageView: MemeImageView!
    
    // MARK: - Define class method
    
    func configure(imageView: MemeImageView) {
        memeImageView = imageView
        delegate = self
    }
    
    func setImage(viewController: EditMemeViewController, sourceType: UIImagePickerControllerSourceType) {
        self.sourceType = sourceType
        viewController.presentViewController(self, animated: true, completion: nil)
    }
    
    // MARK: - Define class methods inherited from UIImagePickerController
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                memeImageView.pickImage(pickedImage)
            }
            
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}