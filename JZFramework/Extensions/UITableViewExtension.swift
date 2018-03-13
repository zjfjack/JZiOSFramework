//
//  UITableViewExtension.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

extension UITableView{
    
    public func registerCell(_ cellClasses: [UITableViewCell.Type]) {
        cellClasses.forEach({
            self.register($0, forCellReuseIdentifier: $0.className)
        })
    }
    
    public func setupDefault(viewController: UIViewController, showSeparator: Bool=true) {
        self.delegate = (viewController as! UITableViewDelegate)
        self.dataSource = (viewController as! UITableViewDataSource)
        setupDefault(showSeparator)
    }
    
    public func setupDefault(view: UIView, showSeparator: Bool=true) {
        self.delegate = (view as! UITableViewDelegate)
        self.dataSource = (view as! UITableViewDataSource)
        setupDefault(showSeparator)
    }
    
    private func setupDefault(_ showSeparator: Bool) {
        self.tableFooterView = UIView()
        
        if showSeparator{
            self.separatorInset = .zero
            self.layoutMargins = .zero
        } else {
            self.separatorStyle = .none
        }
        //fix separator cannot full width on iPad
        self.cellLayoutMarginsFollowReadableWidth = false
    }
}
