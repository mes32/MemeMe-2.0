//
//  MemeTextField.swift
//  MemeMe 2.0
//
//  Created by Michael Stockman on 9/10/16.
//  Copyright © 2016 Michael Stockman. 
//

import Foundation
import UIKit

class MemeTextField: UITextField {
    
    // MARK: - Define the style of text in the textfield
    
    fileprivate static let helvetica: String = "HelveticaNeue-CondensedBlack"
    fileprivate static let fontSize: CGFloat = 36
    fileprivate static let standardLine: UIColor = UIColor.black
    fileprivate static let standardFill: UIColor = UIColor.white
    fileprivate static let grayedLine: UIColor = UIColor.darkGray
    fileprivate static let grayedFill: UIColor = UIColor.lightGray
    fileprivate static let strokeWidth: Double = -4.0
    
    fileprivate let grayedTextAttributes = [
        NSFontAttributeName : UIFont(name: helvetica, size: fontSize)!,
        NSStrokeColorAttributeName : grayedLine,
        NSForegroundColorAttributeName : grayedFill,
        NSStrokeWidthAttributeName : strokeWidth
    ] as [String : Any]
    
    fileprivate let standardTextAttributes = [
        NSFontAttributeName : UIFont(name: helvetica, size: fontSize)!,
        NSStrokeColorAttributeName : standardLine,
        NSForegroundColorAttributeName : standardFill,
        NSStrokeWidthAttributeName : strokeWidth
    ] as [String : Any]
    
    // MARK: - Define the initial state of the textfield
    
    var defaultText: String = ""
    var edited: Bool = false
    
    // MARK: - Implement custom class methods
    
    func setup(defaultText newDefaultText: String, delegate newDelegate: UITextFieldDelegate) {
        setStartingText(newDefaultText)
        reset()
        
        delegate = newDelegate
        textAlignment = .center
    }
    
    func setStartingText(_ defaultText: String) {
        self.defaultText = defaultText
    }
    
    func reset() {
        setTextAttributesGrayed()
        super.text = defaultText
        edited = false
    }
    
    // MARK: - Implement methods inherited from UITextField
    
    func wasEdited() -> Bool {
        return edited
    }
    
    func setTextAttributesStandard() {
        defaultTextAttributes = standardTextAttributes
        textAlignment = .center
    }
    
    func setTextAttributesGrayed() {
        defaultTextAttributes = grayedTextAttributes
        textAlignment = .center
    }
    
}
