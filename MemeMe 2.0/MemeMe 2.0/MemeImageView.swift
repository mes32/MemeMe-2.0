//
//  MemeImageView.swift
//  MemeMe 2.0
//
//  Created by Michael Stockman on 9/15/16.
//  Copyright © 2016 Michael Stockman.
//

import Foundation
import UIKit

class MemeImageView: UIImageView {
    
    // MARK: - Define image offset struct
    
    struct ImageOffset {
        var x: CGFloat
        var y: CGFloat
    }
    
    // MARK: - Constant default colors for the background behind the meme
    
    let defaultBackgroundColor = UIColor.gray
    let chosenBackgroundColor = UIColor.black
    
    // MARK: - Class attributes
    
    var editMemeViewController: EditMemeViewController!
    var backgroundView: UIView!
    var button: UIBarButtonItem!
    var imagePicker: MemeImagePickerController!
    
    // MARK: - General class methods
    
    func configure(_ viewContoller: EditMemeViewController, background: UIView, shareButton: UIBarButtonItem) {
        editMemeViewController = viewContoller
        backgroundView = background
        backgroundView.backgroundColor = defaultBackgroundColor
        button = shareButton
        
        imagePicker = MemeImagePickerController()
        imagePicker.configure(self)
    }
    
    func setMemeImage(_ pickedImage: UIImage) {
        image = pickedImage
        editMemeViewController.setTextFieldPadding()
        backgroundView.backgroundColor = chosenBackgroundColor
        button!.isEnabled = true
    }
    
    // MARK: - Methods for choosing images from either the camera or photo album
    
    func getImageFromCamera(_ viewController: EditMemeViewController) {
        imagePicker.setImage(viewController, sourceType: UIImagePickerControllerSourceType.camera)
    }
    
    func getImageFromAlbum(_ viewController: EditMemeViewController) {
        imagePicker.setImage(viewController, sourceType: UIImagePickerControllerSourceType.photoLibrary)
    }
    
    func getImageOffsets() -> ImageOffset {
        // From Stackoverflow: http://stackoverflow.com/questions/2351002/know-the-real-bounds-of-an-image-in-uiimageview
        
        let viewX: CGFloat = frame.origin.x
        let viewY: CGFloat = frame.origin.y
        let viewWidth: CGFloat = frame.width
        let viewHeight: CGFloat = frame.height
        
        if let image: UIImage = image! as UIImage {
            
            var imageX: CGFloat = 0.0
            var imageY: CGFloat = 0.0
            let imageWidth: CGFloat = image.size.width
            let imageHeight: CGFloat = image.size.height
            
            let scaleFactorX: CGFloat = viewWidth / imageWidth
            let scaleFactorY: CGFloat = viewHeight / imageHeight
            
            if ( scaleFactorX < scaleFactorY ) {
                imageX = viewX
                imageY = viewY + ((viewHeight - scaleFactorX*imageHeight) / 2)  // TODO: Make sure this works
            } else {
                imageX = viewX + ((viewWidth - scaleFactorY*imageWidth) / 2)    // TODO: Make sure this works
                imageY = viewY
            }
            
            let offsetX = imageX - viewX
            let offsetY = imageY - viewY
            
            return ImageOffset(x: offsetX, y: offsetY)
            
        }
    }
}
