//
//  ToastUtil.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 22/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

open class ToastUtil {
    
    public enum ToastPosition {
        case top, bottom
    }
    
    static private let defaultLabelSidesPadding: CGFloat = 20
    
    static private let defaultMidMinWidth: CGFloat = 80
    static private let defaultMidMaxWidth: CGFloat = 300
    static private let defaultMidMinHeight: CGFloat = 40
    static private let defaultMidToBottom: CGFloat = 20 + UITabBarController().tabBar.frame.height
    
    static private let defaultTopBotFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static private let defaultTopBotTextColor = UIColor.white
    static private let defaultTopBotBgColor = UIColor.darkGray
    static private let defaultTopBotHeight = UIApplication.shared.statusBarFrame.height + UINavigationController().navigationBar.frame.height
    
    static private let defaultExistTime: TimeInterval = 1.5
    static private let defaultShowTime: TimeInterval = 0.5
    
    static private var toastView: UIView!
    static private var gestureView: UIView!
    static private var toastLabel: UILabel!
    static private var toastToTopConstraint: NSLayoutConstraint!
    static private var toastPosition: ToastPosition!
    
    public static func toastMessageInTheMiddle(_ message: String, bgColor: UIColor?=nil, textColor: UIColor?=nil, existTime: TimeInterval?=nil) {
        guard let currentWindow = UIApplication.shared.delegate?.window! else { return }
        
        let toastView = MiddleToastView(message: message, bgColor: bgColor, textColor: textColor)
        currentWindow.addSubview(toastView)
        
        var bottomYAnchor: NSLayoutYAxisAnchor
        // Support iPhone X
        if #available(iOS 11.0, *) {
            bottomYAnchor = currentWindow.safeAreaLayoutGuide.bottomAnchor
        } else {
            bottomYAnchor = currentWindow.bottomAnchor
        }
        toastView.setAnchorCenterHorizontallyTo(view: currentWindow, bottomAnchor: (bottomYAnchor, -defaultMidToBottom))
        toastView.heightAnchor.constraint(greaterThanOrEqualToConstant: defaultMidMinHeight).isActive = true
        toastView.widthAnchor.constraint(lessThanOrEqualToConstant: defaultMidMaxWidth).isActive = true
        toastView.widthAnchor.constraint(greaterThanOrEqualToConstant: defaultMidMinWidth).isActive = true
        
        let delay = existTime ?? defaultExistTime
        UIView.animate(withDuration: defaultShowTime, delay: 0, options: .curveEaseInOut, animations: {
            toastView.alpha = 1
            toastView.toastLabel.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: defaultShowTime, delay: delay, options: .curveEaseInOut, animations: {
                toastView.alpha = 0
                toastView.toastLabel.alpha = 0
            }, completion: { _ in
                toastView.removeFromSuperview()
            })
        })
    }
    
    public static func toastMessageFromTopOrBottom(message: String, toastPosition: ToastPosition = .top, bgColor: UIColor? = nil,
                                                   existTime: TimeInterval? = nil, hideStatusBar: Bool = true) {
        guard let currentWindow = UIApplication.shared.delegate?.window!, toastView == nil else { return }
        
        self.toastPosition = toastPosition
        let isFromTop = toastPosition == .top
        toastView = UIView()
        toastView.backgroundColor = bgColor ?? defaultTopBotBgColor
        addToastLabelForTopBot(message: message)
        currentWindow.addSubview(toastView)
        
        let topAnchorTuple = isFromTop ? (currentWindow.topAnchor, -defaultTopBotHeight) : (currentWindow.bottomAnchor, 0)
        toastToTopConstraint = toastView.topAnchor.constraint(equalTo: topAnchorTuple.0, constant: topAnchorTuple.1)
        toastToTopConstraint.isActive = true
        
        toastView.setAnchorConstraintsEqualTo(heightAnchor: defaultTopBotHeight, leadingAnchor: (currentWindow.leadingAnchor, 0), trailingAnchor: (currentWindow.trailingAnchor, 0))
        
        toastViewAddSwipeBackGesture(isFromTop: toastPosition == .top, currentWindow: currentWindow)
        
        let delay = existTime ?? defaultExistTime
        let shouldHideStatusBar = hideStatusBar && isFromTop
        if shouldHideStatusBar { currentWindow.windowLevel = UIWindowLevelStatusBar }
        
        UIView.animate(withDuration: defaultShowTime, delay: 0, options: .curveEaseInOut, animations: {
            toastView.transform = CGAffineTransform(translationX: 0, y: isFromTop ? defaultTopBotHeight : -defaultTopBotHeight)
            toastLabel.alpha = 1
        })
        
        UIView.animate(withDuration: defaultShowTime, delay: delay + defaultShowTime, options: .curveEaseInOut, animations: {
            toastView.transform = CGAffineTransform.identity
            toastLabel.alpha = 0
        }, completion: { isFinished in
            guard isFinished else { return }
            if shouldHideStatusBar { currentWindow.windowLevel = UIWindowLevelNormal }
            toastView?.removeFromSuperview()
            gestureView?.removeFromSuperview()
            toastView = nil
        })
    }
    
    private static func toastViewAddSwipeBackGesture(isFromTop: Bool, currentWindow: UIWindow) {
        let gestureIndicator = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        let indicatorSize = CGSize(width: 40, height: 4)
        let indicatorToEdge: CGFloat = 5
        gestureIndicator.alpha = 0.8
        gestureIndicator.layer.cornerRadius = indicatorSize.height/2
        gestureIndicator.clipsToBounds = true
        toastView.addSubview(gestureIndicator)
        if isFromTop {
            gestureIndicator.setAnchorCenterHorizontallyTo(view: toastView, widthAnchor: indicatorSize.width, heightAnchor: indicatorSize.height, bottomAnchor: (toastView.bottomAnchor, -indicatorToEdge))
        } else {
            gestureIndicator.setAnchorCenterHorizontallyTo(view: toastView, widthAnchor: indicatorSize.width, heightAnchor: indicatorSize.height, topAnchor: (toastView.topAnchor, indicatorToEdge))
        }
        
        gestureView = UIView()
        currentWindow.addSubview(gestureView)
        let topAnchorTuple = isFromTop ? (currentWindow.topAnchor, 0) : (currentWindow.bottomAnchor, -defaultTopBotHeight)
        gestureView.setAnchorConstraintsEqualTo(heightAnchor: defaultTopBotHeight, topAnchor: topAnchorTuple, leadingAnchor: (currentWindow.leadingAnchor, 0), trailingAnchor: (currentWindow.trailingAnchor, 0))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureViewTapped(_:)))
        gestureView.addGestureRecognizer(tapGesture)
        gestureView.isUserInteractionEnabled = true
    }
    
    @objc private static func gestureViewTapped(_ recognizer: UIGestureRecognizer) {
        guard let currentWindow = UIApplication.shared.delegate?.window!, toastView != nil else { return }
        
        gestureView.removeFromSuperview()
        toastView.layer.sublayers?.forEach { $0.removeAllAnimations() }
        toastView.layer.removeAllAnimations()
        
        toastLabel.alpha = 1
        let isFromTop = toastPosition == .top
        let presentLayer = toastView.layer.presentation()!
        let originYTop = presentLayer.frame.origin.y
        let originYBottom = currentWindow.frame.height - originYTop
        toastToTopConstraint.constant = isFromTop ? originYTop : -originYBottom
        
        UIView.animate(withDuration: 0.2, animations: {
            toastLabel.alpha = 0
            toastView.transform = CGAffineTransform(translationX: 0, y: isFromTop ? -(defaultTopBotHeight+originYTop) : originYBottom)
        }, completion: { _ in
            currentWindow.windowLevel = UIWindowLevelNormal
            toastView?.removeFromSuperview()
            toastView = nil
        })
    }
    
    private static func addToastLabelForTopBot(message: String) {
        toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = defaultTopBotFont
        toastLabel.textColor = defaultTopBotTextColor
        toastLabel.textAlignment = .center
        toastLabel.alpha = 0
        toastView.addSubview(toastLabel)
        let centerYConstant: CGFloat = {
            // Support iPhone X
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            let hasNotch: Bool = statusBarHeight > 20
            let shouldAdjustYOffset = hasNotch && UIApplication.shared.statusBarOrientation.isPortrait && toastPosition == .top
            return shouldAdjustYOffset ? statusBarHeight/2 - 15 : 0
        }()
        toastLabel.centerYAnchor.constraint(equalTo: toastView.centerYAnchor, constant: centerYConstant).isActive = true
        toastLabel.setAnchorConstraintsEqualTo(leadingAnchor: (toastView.leadingAnchor, defaultLabelSidesPadding), trailingAnchor: (toastView.trailingAnchor, -defaultLabelSidesPadding))
    }
}

fileprivate class MiddleToastView: UIView {
    
    private let defaultMidFont = UIFont.systemFont(ofSize: 13)
    private let defaultMidBgColor = UIColor(hex: 0xE8E8E8)
    private let defaultTextColor = UIColor.darkGray
    private let labelTopBottomPadding: CGFloat = 10
    private let labelSidesPadding: CGFloat = 20
    
    let toastLabel = UILabel()
    
    init(message: String, bgColor: UIColor?=nil, textColor: UIColor?=nil) {
        super.init(frame: .zero)
        self.backgroundColor = bgColor ?? defaultMidBgColor
        toastLabel.text = message
        toastLabel.textColor = textColor ?? defaultTextColor
        
        setupToastLabel()
        setupView()
    }
    
    func setupView() {
        self.alpha = 0
        self.addSubview(toastLabel)
        toastLabel.setAnchorConstraintsEqualTo(topAnchor: (self.topAnchor, labelTopBottomPadding), bottomAnchor: (self.bottomAnchor, -labelTopBottomPadding), leadingAnchor: (self.leadingAnchor, labelSidesPadding), trailingAnchor: (self.trailingAnchor, -labelSidesPadding))
    }
    
    func setupToastLabel() {
        toastLabel.textAlignment = .center
        toastLabel.alpha = 0
        toastLabel.font = defaultMidFont
        toastLabel.numberOfLines = 0
        toastLabel.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = bounds.height / 2
    }
}
