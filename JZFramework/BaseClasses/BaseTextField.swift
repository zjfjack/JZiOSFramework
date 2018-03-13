//
//  BaseTextField.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {
    
    public init(text: String? = nil, placeholder: String? = nil, style: UITextBorderStyle? = nil,
                font: UIFont? = nil, textColor: UIColor? = nil) {
        
        super.init(frame: .zero)
        
        self.text = text ?? ""
        self.placeholder = placeholder ?? ""
        self.borderStyle = style ?? UITextBorderStyle.roundedRect
        self.font = font ?? UIFont.getRegularText(Constants.defaultFontSize)
        self.textColor = textColor ?? Constants.defaultTextColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
