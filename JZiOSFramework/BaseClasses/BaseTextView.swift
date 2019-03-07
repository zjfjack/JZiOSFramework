//
//  BaseTextView.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

open class BaseTextView: UITextView {
    
    private var placeholder: BaseLabel?
    
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
    
    public func setPlaceholder(text: String) {
        if placeholder == nil {
            placeholder = BaseLabel(text: text, font: self.font, textColor: UIColor(hex: 0xCCCCCC))
            placeholder!.numberOfLines = 0
        } else {
            placeholder!.text = text
        }
        self.addSubview(placeholder!)
        placeholder!.setAnchorConstraintsEqualTo(topAnchor: (topAnchor, 0), leadingAnchor: (leadingAnchor, 2), trailingAnchor: (trailingAnchor, 0))
    }
    
    public func clearPlaceholder() {
        placeholder?.removeFromSuperview()
    }

}
