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
    
    // MARK: - Constant default colors for the background behind the meme
    
    let defaultBackgroundColor = UIColor.grayColor()
    let chosenBackgroundColor = UIColor.blackColor()
    
    // MARK: - Class attributes
    
    var backgroundView: UIView!
    var button: UIBarButtonItem!
    var imagePicker: MemeImagePickerController!
    
    // MARK: - General class methods
    
    func configure(background: UIView, shareButton: UIBarButtonItem) {
        backgroundView = background
        backgroundView.backgroundColor = defaultBackgroundColor
        button = shareButton
        
        imagePicker = MemeImagePickerController()
        imagePicker.configure(self)
    }
    
    func pickImage(pickedImage: UIImage) {
        image = pickedImage
        sizeToFit()
        backgroundView!.backgroundColor = chosenBackgroundColor
        button!.enabled = true
    }
    
    // MARK: - Methods for choosing images from either the camera or photo album
    
    func getImageFromCamera(viewController: EditMemeViewController) {
        imagePicker.setImage(viewController, sourceType: UIImagePickerControllerSourceType.Camera)
    }
    
    func getImageFromAlbum(viewController: EditMemeViewController) {
        imagePicker.setImage(viewController, sourceType: UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    func getImageRect() -> CGRect {
        // From Stackoverflow but pretty heavily modified: http://stackoverflow.com/questions/2351002/know-the-real-bounds-of-an-image-in-uiimageview
        
        let viewX: CGFloat = frame.origin.x
        let viewY: CGFloat = frame.origin.y
        let viewWidth: CGFloat = frame.width
        let viewHeight: CGFloat = frame.height
        
        if let image: UIImage = image! as UIImage {
            
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
