//
//  BaseTextView.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

open class BaseTextView: UITextView {
    
    public init(text: String? = nil, font: UIFont? = nil,
                textColor: UIColor? = nil, backgroundColor: UIColor? = nil) {
        
        super.init(frame: .zero, textContainer: nil)
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        self.text = text ?? ""
        self.font = font ?? UIFont.getRegularText(Constants.defaultFontSize)
        self.textColor = textColor ?? Constants.defaultTextColor
        self.backgroundColor = backgroundColor ?? Constants.defaultViewBackgroundColor
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
