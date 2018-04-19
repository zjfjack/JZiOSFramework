//
//  UserDefaultsExtension.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    private static let deviceTokenKey = "deviceToken"
    
    //MARK: - Remote Notifications
    public static func setDeviceToken(_ deviceToken: String) {
        standard.set(deviceToken, forKey: deviceTokenKey)
    }
    
    public static func getDeviceToken() -> String? {
        return standard.string(forKey: deviceTokenKey)
    }
    
}
