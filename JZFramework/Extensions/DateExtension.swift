//
//  DateExtension.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation

extension Date {
    
    public static let defaultDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = Calendar.current.timeZone
        return dateFormatter
    }()
    
    public static let defaultDisplayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        let formatStr = Date.isDevice24h() ? "dd/MM/yyyy HH:mm" : "dd/MM/yyyy hh:mm a"
        dateFormatter.dateFormat = formatStr
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = Calendar.current.timeZone
        return dateFormatter
    }()
    
    public static func isDevice24h() -> Bool{
        let formatString = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current)
        return !formatString!.contains("a")
    }
    
    //Date Calculate
    public func add(component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
}
