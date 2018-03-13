//
//  UINavigationControllerExtension.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

extension UINavigationController {
    
    public func pushViewControllerHideBottomBar(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController, animated: animated)
    }
    
}
