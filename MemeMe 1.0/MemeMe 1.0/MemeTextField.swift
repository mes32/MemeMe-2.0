//
//  MemeTextField.swift
//  MemeMe 1.0
//
//  Created by Michael Stockman on 9/10/16.
//  Copyright © 2016 Michael Stockman. 
//

import Foundation
import UIKit

class MemeTextField: UITextField {
    
    private let grayedTextAttributes = [
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 36)!,
        NSStrokeColorAttributeName : UIColor.darkGrayColor(),
        NSForegroundColorAttributeName : UIColor.lightGrayColor(),
        NSStrokeWidthAttributeName : -4.0
    ]
    
    private let standardTextAttributes = [
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 36)!,
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSStrokeWidthAttributeName : -4.0
    ]
    
    var defaultText: String = ""
    var edited: Bool = false
    
    func setup(defaultText newDefaultText: String, delegate newDelegate: UITextFieldDelegate) {
        setStartingText(newDefaultText)
        reset()
        
        delegate = newDelegate
        textAlignment = .Center
    }
    
    func setStartingText(defaultText: String) {
        self.defaultText = defaultText
    }
    
    func reset() {
        setTextAttributesGrayed()
        super.text = defaultText
        edited = false
    }
    
    func wasEdited() -> Bool {
        return edited
    }
    
    func setTextAttributesStandard() {
        defaultTextAttributes = standardTextAttributes
        textAlignment = .Center
    }
    
    func setTextAttributesGrayed() {
        defaultTextAttributes = grayedTextAttributes
        textAlignment = .Center
    }
    
}
