//
//  BaseTextView.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

class BaseTextView: UITextView {
    
    public init(text: String = "", font: UIFont = UIFont.getRegularText(Constants.defaultFontSize),
                textColor: UIColor = Constants.defaultTextColor, backgroundColor: UIColor = Constants.defaultViewBackgroundColor) {
        
        super.init(frame: .zero, textContainer: nil)
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        self.text = text
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
