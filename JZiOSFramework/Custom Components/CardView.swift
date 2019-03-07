//
//  CardView.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 15/8/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

class CardView: UIView {

    var contentView: UIView!
    
    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        setupBasic(cornerRadius)
    }
    
    private func setupBasic(_ cornerRadius: CGFloat) {
        self.backgroundColor = .white
        self.layer.cornerRadius = cornerRadius
        let radiusView = UIView()
        radiusView.layer.masksToBounds = true
        radiusView.layer.cornerRadius = cornerRadius
        contentView = radiusView
        self.addSubview(contentView)
        contentView.setAnchorConstraintsFullSizeTo(view: self)
        self.setDefaultShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
