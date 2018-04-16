//
//  PublicUtil.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation


open class PublicUtil {
    
    //MARK: - AppDelegate Commmon
    public static func registerRemoteNotification(_ application: UIApplication) {
        let notificationTypes: UIUserNotificationType = [.alert, .badge, .sound]
        let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
    }
    
    public static func updateDeviceToken(_ deviceToken: Data) {
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        print(token)
        UserDefaults.setDeviceToken(token)
    }
    
    public static func showLocalPath() {
        print("Local Path: \(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])")
    }
    
    //Cover View for App enter background - Hide content (Privacy)
    public static func showBackgroundCoverView(window: UIWindow?, coverView: inout UIView?) {
        guard let currentWindow = window else {return}
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        coverView = UIVisualEffectView(effect: blurEffect)
        currentWindow.addSubview(coverView!)
        coverView!.setAnchorConstraintsEqualTo(topAnchor: (currentWindow.topAnchor, 0), bottomAnchor: (currentWindow.bottomAnchor, 0), leadingAnchor: (currentWindow.leadingAnchor, 0), trailingAnchor: (currentWindow.trailingAnchor, 0))
        currentWindow.bringSubview(toFront: coverView!)
        coverView!.alpha = 1
    }
    
    public static func hideBackgroundCoverView(coverView: UIView?) {
        UIView.animate(withDuration: 0.2, animations: {
            coverView?.alpha = 0
        }, completion: { _ in
            coverView?.removeFromSuperview()
        })
    }
    
    //Other functions
    public static func isValidEmail(_ emailAddress: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: emailAddress)
    }
    
}
