//
//  NSObjectExtension.swift
//  JZFramework
//
//  Created by Jeff Zhang on 9/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation

extension NSObject {
    
    public var className: String {
        return String(describing: type(of: self))
    }
    
    public class var className: String {
        return String(describing: self)
    }
    
}
