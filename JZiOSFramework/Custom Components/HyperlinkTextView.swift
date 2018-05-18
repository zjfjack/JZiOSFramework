//
//  HyperlinkTextView.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 15/5/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

open class HyperlinkTextView: BaseTextView {
    
    var linkAddress: String
    var linkText: String
    
    public init(text: String, linkAddress: String, linkText: String, font: UIFont?=nil,
                alignment: NSTextAlignment?=nil, textColor: UIColor?=nil, linkColor: UIColor?=nil) {
        self.linkAddress = linkAddress
        self.linkText = linkText
        super.init(text: text, font: font, textColor: textColor, backgroundColor: nil)
        self.textAlignment = alignment ?? .left
        if let linkColor = linkColor { self.tintColor = linkColor }
        
        setupBasic()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBasic() {
        self.isScrollEnabled = false
        self.isEditable = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        let wholeAttributes = [NSAttributedStringKey.font: font!,
                               NSAttributedStringKey.paragraphStyle: paragraphStyle,
                               NSAttributedStringKey.foregroundColor: textColor!]
        let linkAttributes = [NSAttributedStringKey.link: URL(string: linkAddress)!]
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttributes(linkAttributes, range: NSString(string: text).range(of: linkText))
        attributedStr.addAttributes(wholeAttributes, range: NSRange(location: 0, length: attributedStr.length))
        self.attributedText = attributedStr
    }
}
