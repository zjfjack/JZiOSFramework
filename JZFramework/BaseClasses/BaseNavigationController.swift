//
//  BaseNavigationController.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//


//Translucent Navigation Bar Style
class BaseNavigationController: UINavigationController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBarStyle()
    }
    
    private func setupNaviBarStyle() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.backgroundColor = UIColor.clear
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
