//
//  ViewControllerUtil.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation


open class ViewControllerUtil {
    
    // MARK: - HUD
    private static var HUDView: UIView!
    private static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    public static func showDefaultHUDView(_ view: UIView) {
        showHUDView(view: view)
    }
    
    public static func showHUDView(text: String?=nil, view: UIView) {
        
        HUDView = UIView()
        
        let loadingViewHeight: CGFloat = 120
        
        let loadingView = UIView(backgroundColor: UIColor(hex: 0x444444).withAlphaComponent(0.7))
        loadingView.setCornerRadius(10)
        
        let lblText = BaseLabel(textColor: .white)
        lblText.textAlignment = .center
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        
        let stackView = UIStackView(arrangedSubviews: [activityIndicator, lblText], axis: .vertical, spacing: 10)
        
        if let text = text {
            lblText.text = text
        } else {
            lblText.isHidden = true
        }
        
        view.addSubview(HUDView)
        HUDView.addSubview(loadingView)
        loadingView.addSubview(stackView)
        
        HUDView.setAnchorConstraintsFullSizeTo(view: view)
        loadingView.setAnchorConstraintsEqualTo(widthAnchor: loadingViewHeight, heightAnchor: loadingViewHeight, centerXAnchor: view.centerXAnchor, centerYAnchor: view.centerYAnchor)
        stackView.setAnchorConstraintsEqualTo(widthAnchor: 70, heightAnchor: 70, centerXAnchor: loadingView.centerXAnchor, centerYAnchor: loadingView.centerYAnchor)
        activityIndicator.startAnimating()
    }
    
    public static func hideHUDView() {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            HUDView.removeFromSuperview()
        }
    }
    
    
    // MARK: - General
    
    // Be care UISplitViewController in iPad
    public static func getCurrentViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return getCurrentViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return getCurrentViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return getCurrentViewController(controller: presented)
        }
        return controller
    }
    
    // Hide status bar
    public static func showStatusBar() {
        guard let currentVC = getCurrentViewController() else {return}
        currentVC.view.window?.windowLevel = UIWindowLevelNormal
    }
    
    public static func hideStatusBar() {
        guard let currentVC = getCurrentViewController() else {return}
        currentVC.view.window?.windowLevel = UIWindowLevelStatusBar
    }
    
}
