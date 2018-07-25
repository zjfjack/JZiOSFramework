//
//  DeviceUtil.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation
import LocalAuthentication

// iPhone X Support
open class DeviceUtil {
    
    public static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    public static let navigationBarHeight: CGFloat = UINavigationController().navigationBar.frame.height
    public static let naviAndStatusBarHeight: CGFloat = statusBarHeight + navigationBarHeight
    /// Not include the iPhone X bottom gesture bar
    public static let tabBarHeight: CGFloat = UITabBarController().tabBar.frame.height
    @available(iOS 11.0, *)
    public static let bottomGestureBarHeight: CGFloat = ViewControllerUtil.getCurrentViewController()?.view.safeAreaInsets.bottom ?? 34
    
    // Will changed when device rotate or iPad Split View
    public static var currentScreenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static var currentScreenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    // Fixed value
    public static var screenWidth: CGFloat = UIScreen.main.nativeBounds.width / UIScreen.main.nativeScale
    public static var screenHeight: CGFloat = UIScreen.main.nativeBounds.height / UIScreen.main.nativeScale
    
    public static let isIPhoneX: Bool = UIDevice.current.userInterfaceIdiom == .phone && screenHeight == 812
    public static let isIPhoneSEOrSmaller: Bool = screenWidth <= 320
    public static let isIPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    //Example: lblTitle.centerYAnchor.constraint(equalTo: naviView.centerYAnchor, constant: centerYOffset).isActive = true
    /// iPhone X statusBar + NavigationBar actual center Y offset (Notch considered)
    /// Should add or minus some adjusment value depend on different situation
    public static let centerYOffsetForContentInNaviBar: CGFloat = statusBarHeight/2
    /// iPhone X bottom gestureBar actual center Y offset
    @available(iOS 11.0, *)
    public static let centerYOffsetForContentInBottomView: CGFloat = -bottomGestureBarHeight/2
    
    
    // MARK: - Biometric Authentication
    public enum BiometryType: String {
        case none = "None"
        case touchID = "Touch ID"
        case faceID = "Face ID"
    }
    
    public enum BiometricState {
        case available
        case notAvailable  // Currently in iOS 11 only exists in Face ID not allowed and for iPhone 4s and iPhone 5
        case lockout, notEnrolled, unknown
    }
    
    public static func getBiometricInfo() -> (state: BiometricState, type: BiometryType) {
        // Get state
        let biometricState: BiometricState
        var authError: NSError?
        let laContext = LAContext()
        if laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            biometricState = .available
        } else {
            switch (authError as! LAError).code {
            case .biometryLockout: biometricState = .lockout
            case .biometryNotAvailable: biometricState = .notAvailable
            case .biometryNotEnrolled: biometricState = .notEnrolled
            default: biometricState = .unknown
            }
        }
        // get type
        let biometricType: BiometryType
        if biometricState == .unknown || biometricState == .notEnrolled {
            biometricType = .none
        } else {
            // Lockout, notEnrolled, notAvailable, available
            if #available(iOS 11.0, *) {
                switch laContext.biometryType {
                case .touchID: biometricType = .touchID
                case .faceID: biometricType = .faceID
                default: biometricType = .none
                }
            } else {
                // Version below iOS 11, notAvailable only happens in devices do not support
                biometricType = biometricState == .notAvailable ? .none : .touchID
            }
        }
        return (biometricState, biometricType)
    }
    
    public static func setupBiometricAuthentication(successAction: @escaping () -> Void, fallbackAction: @escaping () -> Void) {
        
        func presentAllowUsageController() {
            let alertController = UIAlertController(title: "Face ID Not Enabled", message: "We need you turn on Face ID usage in Settings", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
                UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
            }
            alertController.addActions([settingsAction, AlertUtil.getCancelAction()])
            ViewControllerUtil.getCurrentViewController()?.present(alertController, animated: true, completion: nil)
        }
        
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Password"
        var authError: NSError?
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login") { success, error in
                if success {
                    DispatchQueue.main.async {
                        // Login Function
                        successAction()
                    }
                } else {
                    let laError = error as! LAError
                    
                    switch laError.code {
                    case .authenticationFailed:
                        break
                    case .userCancel:
                        break
                    // Fail two times, allow users to login with password
                    case .userFallback:
                        DispatchQueue.main.async {
                            //Another way to login
                            fallbackAction()
                        }
                        break
                    case .biometryNotAvailable:
                        // Face Id Click not allow
                        DispatchQueue.main.async {
                            presentAllowUsageController()
                        }
                    default:
                        DispatchQueue.main.async {
                            ToastUtil.toastMessageInTheMiddle(laError.localizedDescription)
                        }
                    }
                }
            }
        } else {
            //Device not capable scenario //Biometry locked out or not available
            let laError = authError as! LAError
            switch laError.code {
            case .biometryNotAvailable:
                //Face Id Click not allow
                presentAllowUsageController()
                
            case .biometryLockout:
                // Face ID will not be locked for now
                AlertUtil.presentNoFunctionAlertController(title: "Touch ID is locked now", message: "Please use password to login")
            default:
                ToastUtil.toastMessageInTheMiddle(laError.localizedDescription)
            }
        }
    }
    
}
