//
//  MemeImageView.swift
//  MemeMe 1.0
//
//  Created by Michael Stockman on 9/15/16.
//  Copyright © 2016 Michael Stockman.
//

import Foundation
import UIKit

class MemeImageView: UIImageView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var backgroundView: UIImageView?
    var shareButton: UIButton?
    var imagePicker: UIImagePickerController?
    
    func configure(background: UIImageView, shareButton: UIButton) {
        self.backgroundView = background
        self.shareButton = shareButton
        self.imagePicker = UIImagePickerController()
        self.imagePicker!.delegate = self
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            backgroundView!.backgroundColor = UIColor.blackColor()
            self.image = pickedImage
            self.sizeToFit()
            shareButton!.enabled = true
        }
        
        self.imagePicker!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel() {
        self.imagePicker!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getImageRect() -> CGRect {
        // From Stackoverflow but pretty heavily modified: http://stackoverflow.com/questions/2351002/know-the-real-bounds-of-an-image-in-uiimageview
        
        let viewX: CGFloat = self.frame.origin.x
        let viewY: CGFloat = self.frame.origin.y
        let viewWidth: CGFloat = self.frame.width
        let viewHeight: CGFloat = self.frame.height
        
        if let image: UIImage = self.image! as UIImage {
            
            var imageX: CGFloat = 0.0
            var imageY: CGFloat = 0.0
            let imageWidth: CGFloat = image.size.width
            let imageHeight: CGFloat = image.size.height
            
            let ratioX: CGFloat = viewWidth / imageWidth
            let ratioY: CGFloat = viewHeight / imageHeight
            
            if ( ratioX < ratioY ) {
                imageX = viewX
                imageY = viewY + ((viewHeight - ratioX*imageHeight) / 2)
            } else {
                imageX = viewX + ((viewWidth - ratioY*imageWidth) / 2)
                imageY = viewY
            }
            
            let offsetX = imageX - viewX
            let offsetY = imageY - viewY
            let dispImageWidth = viewWidth - 2*offsetX
            let dispImageHeight = viewHeight - 2*offsetY
            
            let imageRect = CGRect(x: imageX, y: imageY, width: dispImageWidth, height: dispImageHeight)
            
            return imageRect
            
        }
    }
}