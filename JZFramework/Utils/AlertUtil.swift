//
//  AlertUtil.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

open class AlertUtil {
    
    //In iPad, actionsheet should give a specific position, change to alert here
    public static func getActionSheetAlertStyle() -> UIAlertControllerStyle {
        return UIDevice.current.userInterfaceIdiom == .phone ? .actionSheet : .alert
    }
    
    public static func getCancelAction(_ title: String = "Cancel") -> UIAlertAction {
        return UIAlertAction(title: title, style: .cancel)
    }
    
    public static func presentNoFunctionAlertController(title:String?=nil, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        
        ViewControllerUtil.getCurrentViewController()?.present(alertController, animated: true)
    }
}


extension UIAlertController {
    
    public func addActions(_ actions: [UIAlertAction]) {
        actions.forEach{
            self.addAction($0)
        }
    }
}
