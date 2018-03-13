//
//  BaseTextField.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {
    
    public init(text: String, placeholder: String, style: UITextBorderStyle = UITextBorderStyle.roundedRect,
                font: UIFont = UIFont.getRegularText(Constants.defaultFontSize), textColor: UIColor = Constants.defaultTextColor) {
        
        super.init(frame: .zero)
        
        self.text = text
        self.placeholder = placeholder
        self.borderStyle = style
        self.font = font
        self.textColor = textColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
