//
//  MemeImagePickerController.swift
//  MemeMe 2.0
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
    
    func configure(_ imageView: MemeImageView) {
        memeImageView = imageView
        delegate = self
    }
    
    func setImage(_ viewController: EditMemeViewController, sourceType: UIImagePickerControllerSourceType) {
        self.sourceType = sourceType
        viewController.present(self, animated: true, completion: nil)
    }
    
    // MARK: - Define class methods inherited from UIImagePickerController
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                memeImageView.setMemeImage(pickedImage)
            }
            
            dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel() {
        dismiss(animated: true, completion: nil)
    }
}
