//
//  ToastUtil.swift
//  JZFramework
//
//  Created by Jeff Zhang on 22/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation

open class ToastUtil {
    
    static private let defaultLabelSidesPadding: CGFloat = 20
    
    static private let defaultMidFont = UIFont.getRegularText(13)
    static private let defaultMidBgColor = UIColor(hex: 0xE8E8E8)
    static private let defaultMidTextColor = UIColor.darkGray
    static private let defaultMidHeight: CGFloat = 40
    static private let defaultMidMinWidth: CGFloat = 80
    static private let defaultMidToBottom: CGFloat = 20 + DeviceUtil.tabBarHeight
    
    static private let defaultTopBotFont = UIFont.getSemiboldText(16)
    static private let defaultTopBotTextColor = UIColor.white
    static private let defaultTopBotBgColor = UIColor.blue
    
    static private let defaultExistTime: TimeInterval = 1.0
    static private let defaultShowTime: TimeInterval = 0.5
    
    public static func toastMessageInTheMiddle(_ message: String, bgColor: UIColor? = nil, existTime: TimeInterval? = nil) {
        
        guard let currentWindow = ViewControllerUtil.getCurrentViewController()?.view.window else { return }
        let toastView = UIView(backgroundColor: defaultMidBgColor)
        toastView.alpha = 0
        toastView.setCornerRadius(defaultMidHeight/2)
        let toastLabel =  addToastLabel(to: toastView, message: message, isMiddle: true)
        
        currentWindow.addSubview(toastView)
        var bottomYAnchor: NSLayoutYAxisAnchor
        //Support iPhone X
        if #available(iOS 11.0, *) {
            bottomYAnchor = currentWindow.safeAreaLayoutGuide.bottomAnchor
        } else {
            bottomYAnchor = currentWindow.bottomAnchor
        }
        
        toastView.setAnchorCenterHorizontallyTo(view: currentWindow, heightAnchor: defaultMidHeight, bottomAnchor: (bottomYAnchor, -defaultMidToBottom))
        toastView.widthAnchor.constraint(greaterThanOrEqualToConstant: defaultMidMinWidth).isActive = true
        
        let delay = existTime ?? defaultExistTime
        UIView.animate(withDuration: defaultShowTime, delay: 0, options: .curveEaseInOut, animations: {
            toastView.alpha = 1
            toastLabel.alpha = 1
        }, completion: { _ in
            
            UIView.animate(withDuration: defaultShowTime, delay: delay, options: .curveEaseInOut, animations: {
                toastView.alpha = 0
                toastLabel.alpha = 0
            }, completion: { _ in
                toastView.removeFromSuperview()
            })
        })
    }
    
    public static func toastMessageFromTopOrBottom(_ message: String, isFromTop: Bool = true, bgColor: UIColor? = nil, existTime: TimeInterval? = nil) {
        
        guard let currentWindow = ViewControllerUtil.getCurrentViewController()?.view.window else { return }
        
        let toastWidth = DeviceUtil.screenWidth
        let toastHeight = DeviceUtil.naviAndStatusBarHeight
        
        var toastView: UIView
        toastView = isFromTop ? UIView(frame: CGRect(x: 0, y: -toastHeight, width: toastWidth, height: toastHeight)) :
                                UIView(frame: CGRect(x: 0, y: DeviceUtil.screenHeight + toastHeight, width: toastWidth, height: toastHeight))
        
        toastView.backgroundColor = (bgColor ?? defaultTopBotBgColor).withAlphaComponent(0.95)
        let toastLabel = addToastLabel(to: toastView, message: message, isMiddle: false)
        
        currentWindow.addSubview(toastView)
        
        let delay = existTime ?? defaultExistTime
        UIView.animate(withDuration: defaultShowTime, delay: 0, options: .curveEaseInOut, animations: {
            toastView.transform = CGAffineTransform(translationX: 0, y: isFromTop ? toastHeight : -toastHeight)
            toastLabel.alpha = 1
        }, completion: { _ in
            
            UIView.animate(withDuration: defaultShowTime, delay: delay, options: .curveEaseInOut, animations: {
                toastView.transform = CGAffineTransform.identity
                toastLabel.alpha = 0
            }, completion: { _ in
                toastView.removeFromSuperview()
            })
        })
    }
    
    private static func addToastLabel(to toastView: UIView, message: String, isMiddle: Bool) -> UILabel {
        let font = isMiddle ? defaultMidFont : defaultTopBotFont
        let textColor = isMiddle ? defaultMidTextColor : defaultTopBotTextColor
        let toastLabel = BaseLabel(text: message, font: font, textColor: textColor)
        toastLabel.textAlignment = .center
        toastLabel.alpha = 0
        toastView.addSubview(toastLabel)
        toastLabel.setAnchorCenterVerticallyTo(view: toastView, heightAnchor: defaultMidHeight, leadingAnchor: (toastView.leadingAnchor, defaultLabelSidesPadding), trailingAnchor: (toastView.trailingAnchor, -defaultLabelSidesPadding))
        return toastLabel
    }
    
}
