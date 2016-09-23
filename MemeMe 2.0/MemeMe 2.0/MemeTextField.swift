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
    
    private static let helvetica: String = "HelveticaNeue-CondensedBlack"
    private static let fontSize: CGFloat = 36
    private static let standardLine: UIColor = UIColor.blackColor()
    private static let standardFill: UIColor = UIColor.whiteColor()
    private static let grayedLine: UIColor = UIColor.darkGrayColor()
    private static let grayedFill: UIColor = UIColor.lightGrayColor()
    private static let strokeWidth: Double = -4.0
    
    private let grayedTextAttributes = [
        NSFontAttributeName : UIFont(name: helvetica, size: fontSize)!,
        NSStrokeColorAttributeName : grayedLine,
        NSForegroundColorAttributeName : grayedFill,
        NSStrokeWidthAttributeName : strokeWidth
    ]
    
    private let standardTextAttributes = [
        NSFontAttributeName : UIFont(name: helvetica, size: fontSize)!,
        NSStrokeColorAttributeName : standardLine,
        NSForegroundColorAttributeName : standardFill,
        NSStrokeWidthAttributeName : strokeWidth
    ]
    
    // MARK: - Define the initial state of the textfield
    
    var defaultText: String = ""
    var edited: Bool = false
    
    // MARK: - Implement custom class methods
    
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
    
    // MARK: - Implement methods inherited from UITextField
    
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
