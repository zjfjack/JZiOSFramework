//
//  UIColorExtension.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 9/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation

extension UIColor {
    
    //Get UIColor by RGB
    public convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    //Get UIColor by HEX
    public convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}
