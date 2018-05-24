//
//  SettingsUtil.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 21/5/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation

open class SettingsUtil {
    
//    func switchValueChanged(type: SettingsViewModel.CellType, toValue: Bool) {
//        switch type {
//        case .enableFaceID, .enableTouchID:
//            handleAllowBiometricAuthChanged(isAllow: toValue)
//        case .notifications:
//            handleAllowNotificationsChanged(isAllow: toValue)
//        default:
//            break
//        }
//    }
//
//    private func handleAllowBiometricAuthChanged(isAllow: Bool) {
//        UserDefaults.setAllowBiometricAuth(isAllow ? .allow : .notAllow)
//        var alertController: UIAlertController!
//        let biometricStatus = BaseDeviceUtil.getBiometricStatus()
//        let biometricType  = BaseDeviceUtil.getSupportBiometryType()
//        switch biometricStatus {
//        case .notAvailable:
//            let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
//                if let url = URL(string: UIApplicationOpenSettingsURLString) { UIApplication.shared.openURL(url) }
//            }
//            alertController = UIAlertController(title: "\(biometricType.rawValue) Not Enabled", message: "We need you turn on Face ID usage in Settings", preferredStyle: .alert)
//            alertController.addActions([settingsAction, getCancelAction()])
//        case .lockout:
//            alertController = UIAlertController(title: "\(biometricType.rawValue) is locked now", message: "Please use password to login or unlock it in Settings", preferredStyle: .alert)
//            alertController.addAction(getCancelAction("OK"))
//        default:
//            return
//        }
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    private func handleAllowNotificationsChanged(isAllow: Bool) {
//        if UIApplication.shared.isRegisteredForRemoteNotifications {
//            if UserDefaults.getAllowNotifications() {
//                // State 1: System On, User On
//                let optionMenu = UIAlertController(title: nil, message: "ESUPERFUND will NOT send you any Notifications which may include alerts, sounds and icon badges. These can be configured in your phone Settings.", preferredStyle: BaseAlertUtil.getActionSheetAlertStyle())
//                let dontReceiveAction = UIAlertAction(title: "Turn Off Push Notifications", style: .destructive) { _ in
//                    // TODO: Update allowNotifications to false remote
//                    self.updateAllowNotificationsRemote(false)
//                    UserDefaults.setAllowNotifications(false)
//                }
//                optionMenu.addActions([dontReceiveAction, getCancelAction()])
//                self.present(optionMenu, animated: true, completion: nil)
//
//            } else{
//                // State 2: System On, User Off
//                // TODO: Update allowNotifications to true remote
//                updateAllowNotificationsRemote(true)
//                UserDefaults.setAllowNotifications(true)
//            }
//        } else {
//            // State 3: System Off
//            let alertController = UIAlertController(title: "Notifications Not Enabled", message: "We need you turn on Notifications service in Settings", preferredStyle: .alert)
//            let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
//                if !UserDefaults.getAllowNotifications() {
//                    // State 4: System Off, User Off
//                    self.updateAllowNotificationsRemote(true)
//                    UserDefaults.setAllowNotifications(true)
//                }
//                if let url = URL(string: UIApplicationOpenSettingsURLString) { UIApplication.shared.openURL(url) }
//            }
//            alertController.addActions([settingsAction, getCancelAction()])
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
//
//    // TODO
//    private func updateAllowNotificationsRemote(_ isAllow: Bool) {
//
//    }
//
//    private func getCancelAction(_ title: String? = nil) -> UIAlertAction {
//        return UIAlertAction(title: title ?? "Cancel", style: title == nil ? .cancel : .default) { _ in
//            self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
//        }
//    }
    
}
