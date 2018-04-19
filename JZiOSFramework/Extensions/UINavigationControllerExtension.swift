//
//  UINavigationControllerExtension.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

extension UINavigationController {
    
    public func pushViewControllerHideBottomBar(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController, animated: animated)
    }
    
    public func popToViewController(_ className: AnyClass) {
        
        for vc in viewControllers {
            if vc.isKind(of: className) {
                self.popToViewController(vc, animated: true)
                break
            }
        }
    }
}
