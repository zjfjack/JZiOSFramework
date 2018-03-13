//
//  DeviceUtil.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation
import LocalAuthentication

//iPhone X Support
open class DeviceUtil {
    
    public static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    public static let navigationBarHeight: CGFloat = UINavigationController().navigationBar.frame.height
    public static let naviAndStatusBarHeight: CGFloat = statusBarHeight + navigationBarHeight
    
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public static let isIPhoneX: Bool = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436
    
    public static let isIPhoneSEOrSmaller: Bool = UIScreen.main.nativeBounds.height <= 568
    
    public static let isIPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    //Example: lblTitle.centerYAnchor.constraint(equalTo: naviView.centerYAnchor, constant: centerYOffset).isActive = true
    public static let centerYOffsetForContentInNaviBar: CGFloat = statusBarHeight/2 - 8
    
    
    //MARK: - Biometric Authentication
    public enum BiometryType: String {
        case none = "None"
        case touchID = "Touch ID"
        case faceID = "Face ID"
    }
    
    public static func getSupportBiometryType() -> BiometryType {
        
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Login"
        var authError: NSError?
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            if #available(iOS 11.0, *) {
                if localAuthenticationContext.biometryType == .touchID {
                    return .touchID
                } else if localAuthenticationContext.biometryType == .faceID {
                    return .faceID
                } else {
                    return .none
                }
            } else {
                return .touchID
            }
        } else {
            return .none
        }
    }
    
}
