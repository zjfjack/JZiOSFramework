//
//  BaseViewController.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

open class BaseViewController: UIViewController {
    
    private let naviBarItemDefaultWidth: CGFloat = 20
    private var titleLabel: BaseLabel!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefault()
    }
    
    func setupDefault() {
        view.backgroundColor = .white
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    public func setupDefaultNavigationBar(title: String? = nil, leftView: Any? = nil, rightView: Any? = nil) {
        setupNavigationBackgroundView()
        
        if let title = title {
            titleLabel = BaseLabel(text: title, font: UIFont.getBoldText(20), textColor: UIColor.white)
            navigationItem.titleView = titleLabel
            titleLabel.textAlignment = .center
            titleLabel.sizeToFit()
        }
        
        for (index, view) in [leftView, rightView].enumerated() {
            guard let v = view else {continue}
            
            var barItem: UIBarButtonItem
            
            if let button = v as? UIButton {
                if #available(iOS 11.0, *) {
                    button.setAnchorConstraintsEqualTo(widthAnchor: naviBarItemDefaultWidth, heightAnchor: naviBarItemDefaultWidth)
                } else {
                    button.frame = CGRect(x: 0, y: 0, width: naviBarItemDefaultWidth, height: naviBarItemDefaultWidth)
                }
                barItem = UIBarButtonItem(customView: button)
            } else if let label = v as? UILabel {
                label.sizeToFit()
                barItem = UIBarButtonItem(customView: label)
            } else {
                barItem = v as! UIBarButtonItem
            }
            
            if index == 0{
                navigationItem.leftBarButtonItem = barItem
            } else {
                navigationItem.rightBarButtonItem = barItem
            }
        }
    }
    
    public func updateTitleText(_ text: String) {
        titleLabel?.text = text
        titleLabel?.sizeToFit()
    }
    
    private func setupNavigationBackgroundView() {
        //TODO: - BackgroundView for NavigationBar
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

