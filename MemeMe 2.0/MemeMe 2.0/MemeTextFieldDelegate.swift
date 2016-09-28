//
//  MemeTextFieldDelegate.swift
//  MemeMe 2.0
//
//  Created by Michael Stockman on 9/13/16.
//  Copyright © 2016 Michael Stockman.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Implement methods inherited from UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let memeTextField = textField as! MemeTextField
        if (!memeTextField.edited) {
            memeTextField.text = ""
        }
        
        memeTextField.setTextAttributesStandard()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let memeTextField = textField as! MemeTextField
        if (memeTextField.text!.trimmingCharacters(in: CharacterSet(charactersIn: " ")).isEmpty) {
            memeTextField.reset()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let memeTextField = textField as! MemeTextField
        memeTextField.edited = true
    
        // Convert typed text to uppercase
        // The following line of code is from Stackoverflow: http://stackoverflow.com/questions/21092182/uppercase-characters-in-uitextfield
        memeTextField.text = (memeTextField.text! as NSString).replacingCharacters(in: range, with:string.uppercased())
    
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}
