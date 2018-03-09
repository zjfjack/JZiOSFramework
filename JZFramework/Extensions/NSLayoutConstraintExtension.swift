//
//  NSLayoutConstraintExtension.swift
//  JZFramework
//
//  Created by Jeff Zhang on 9/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation

extension NSLayoutConstraint {
    
    public enum LayoutAxis {
        case vertical
        case horizontal
    }
    
    //Use this Method to simplify setting constraints by visual format
    public static func getVisualConstraints(_ axis: LayoutAxis, formatsAndOptions: [(String, NSLayoutFormatOptions)], metrics: [String:Any]?, views: [String:Any]) -> [NSLayoutConstraint] {
        
        var constraints = [NSLayoutConstraint]()
        
        for formatAndOption in formatsAndOptions{
            var format = formatAndOption.0
            format = correctFormatString(axis, format: format)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: format, options: formatAndOption.1, metrics: metrics, views: views)
        }
        setTranslatesAutoresizingMaskIntoConstraints(views)
        return constraints
    }
    
    static private func correctFormatString(_ axis: LayoutAxis, format: String) -> String {
        if axis == .vertical{
            var newFormat = ""
            if !format.hasPrefix("V:") {
                newFormat = "V:" + format
                return newFormat
            }
        }
        return format
    }
    
    static private func setTranslatesAutoresizingMaskIntoConstraints(_ views: [String:Any]) {
        views.values.forEach { (view) in
            if let uiview = view as? UIView{
                uiview.translatesAutoresizingMaskIntoConstraints = false
            }
        }
    }
}

/* Examples
 
    let views: [String:Any] = ["lblDescription": lblDescription, "lblUpdateTime": lblUpdateTime, "stvTitle": stvTitle]
    let metrics: [String:Any] = ["vPadding": verticalPadding, "hPadding": horizontalPadding, "stvHeight": stvHeight, "spacing": spacing, "timeWidth": BaseConstants.displayTimeWidth]
 
    let verticalFormatsAndOptions:[(String, NSLayoutFormatOptions)] = [
        ("V:|-vPadding-[stvTitle(stvHeight)]-spacing-[lblDescription]-vPadding-|", [.alignAllLeading]),
        ("V:|-vPadding-[lblUpdateTime]", [])]
 
    let horizontalFormatsAndOptions:[(String, NSLayoutFormatOptions)] = [
        ("H:|-hPadding-[stvTitle]-spacing-[lblUpdateTime(timeWidth)]-hPadding-|", []),
        ("H:|-hPadding-[lblDescription]-hPadding-|", [])]
 
    contentView.addConstraints(NSLayoutConstraint.getVisualConstraints(.horizontal, formatsAndOptions: horizontalFormatsAndOptions, metrics: metrics, views: views))
    contentView.addConstraints(NSLayoutConstraint.getVisualConstraints(.vertical, formatsAndOptions: verticalFormatsAndOptions, metrics: metrics, views: views))
*/
