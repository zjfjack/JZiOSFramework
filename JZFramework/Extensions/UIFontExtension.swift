//
//  UIFontExtension.swift
//  JZFramework
//
//  Created by Jeff Zhang on 9/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation

extension UIFont {
    
    public static func getRegularText(_ size: CGFloat) -> UIFont{
        return UIFont.systemFont(ofSize: size)
    }
    
    public static func getSemiboldText(_ size: CGFloat) -> UIFont{
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    public static func getBoldText(_ size: CGFloat) -> UIFont{
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    public static func getLightText(_ size: CGFloat) -> UIFont{
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    
}
