//
//  MemeImageView.swift
//  MemeMe 1.0
//
//  Created by Michael Stockman on 9/15/16.
//  Copyright © 2016 Michael Stockman.
//

import Foundation
import UIKit

class MemeImageView: UIImageView {
    
    let defaultBackgroundColor = UIColor.grayColor()
    let chosenBackgroundColor = UIColor.blackColor()
    
    var backgroundView: UIView!
    var shareButton: UIBarButtonItem!
    var imagePicker: MemeImagePickerController!
    
    func configure(background: UIView, shareButton: UIBarButtonItem) {
        self.backgroundView = background
        self.backgroundView.backgroundColor = defaultBackgroundColor
        self.shareButton = shareButton
        
        self.imagePicker = MemeImagePickerController()
        self.imagePicker.configure(self)
    }
    
    func pickImage(pickedImage: UIImage) {
        self.image = pickedImage
        self.sizeToFit()
        backgroundView!.backgroundColor = chosenBackgroundColor
        shareButton!.enabled = true
    }
    
    func getImageFromCamera(viewController: ViewController) {
        imagePicker.setImage(viewController, sourceType: UIImagePickerControllerSourceType.Camera)
    }
    
    func getImageFromAlbum(viewController: ViewController) {
        imagePicker.setImage(viewController, sourceType: UIImagePickerControllerSourceType.PhotoLibrary)
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
