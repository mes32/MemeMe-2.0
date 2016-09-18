//
//  MemeTextFieldDelegate.swift
//  MemeMe 1.0
//
//  Created by Michael Stockman on 9/13/16.
//  Copyright © 2016 Michael Stockman.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Implement methods inherited from UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let memeTextField = textField as! MemeTextField
        if (!memeTextField.edited) {
            memeTextField.text = ""
        }
        
        memeTextField.setTextAttributesStandard()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        let memeTextField = textField as! MemeTextField
        if (memeTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " ")).isEmpty) {
            memeTextField.reset()
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let memeTextField = textField as! MemeTextField
        memeTextField.edited = true
    
        // Convert typed text to uppercase
        // The following line of code is from Stackoverflow: http://stackoverflow.com/questions/21092182/uppercase-characters-in-uitextfield
        memeTextField.text = (memeTextField.text! as NSString).stringByReplacingCharactersInRange(range, withString:string.uppercaseString)
    
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}
