//
//  BaseLabel.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

open class BaseLabel: UILabel {
    
    let defaultBackgroundColor = UIColor.clear
    
    public init(text: String = "", font: UIFont = UIFont.getRegularText(Constants.defaultFontSize),
                textColor: UIColor = Constants.defaultTextColor, backgroundColor: UIColor = Constants.defaultViewBackgroundColor) {
        
        super.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //Calculate label size especially for multiple lines
    public static func getLabelWidth(text:String, font:UIFont, height:CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: .greatestFiniteMagnitude, height: height))
        label.font = font
        label.numberOfLines = 0
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
    
    public static func getLabelHeight(text:String, font:UIFont, width:CGFloat, lines: Int = 0) -> CGFloat{
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        label.text = text
        label.font = font
        label.numberOfLines = lines
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        return label.frame.height
    }
}


