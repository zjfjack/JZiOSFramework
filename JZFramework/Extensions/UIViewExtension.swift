//
//  UIViewExtension.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

extension UIView{
    
    public convenience init(backgroundColor: UIColor){
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    //MARK: - Anchor Constranits
    public func setAnchorConstraintsEqualTo(widthAnchor: CGFloat?=nil, heightAnchor: CGFloat?=nil,
                                            centerXAnchor: NSLayoutXAxisAnchor?=nil, centerYAnchor: NSLayoutYAxisAnchor?=nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let width = widthAnchor{
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = heightAnchor{
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let centerX = centerXAnchor{
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerYAnchor{
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    //bottomAnchor & trailingAnchor should be negative
    public func setAnchorConstraintsEqualTo(widthAnchor: CGFloat?=nil, heightAnchor: CGFloat?=nil,
                                            topAnchor: (NSLayoutYAxisAnchor,CGFloat)?=nil, bottomAnchor: (NSLayoutYAxisAnchor,CGFloat)?=nil,
                                            leadingAnchor: (NSLayoutXAxisAnchor,CGFloat)?=nil, trailingAnchor: (NSLayoutXAxisAnchor,CGFloat)?=nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let width = widthAnchor{
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = heightAnchor{
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let topY = topAnchor{
            self.topAnchor.constraint(equalTo: topY.0, constant: topY.1).isActive = true
        }
        
        if let botY = bottomAnchor{
            self.bottomAnchor.constraint(equalTo: botY.0, constant: botY.1).isActive = true
        }
        
        if let leadingX = leadingAnchor{
            self.leadingAnchor.constraint(equalTo: leadingX.0, constant: leadingX.1).isActive = true
        }
        
        if let trailingX = trailingAnchor{
            self.trailingAnchor.constraint(equalTo: trailingX.0, constant: trailingX.1).isActive = true
        }
    }
    
    public func setAnchorCenterVerticallyTo(view: UIView, widthAnchor: CGFloat?=nil, heightAnchor: CGFloat?=nil,
                                            leadingAnchor: (NSLayoutXAxisAnchor,CGFloat)?=nil, trailingAnchor: (NSLayoutXAxisAnchor,CGFloat)?=nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setAnchorConstraintsEqualTo(widthAnchor: widthAnchor, heightAnchor: heightAnchor, centerYAnchor: view.centerYAnchor)
        
        if let leadingX = leadingAnchor{
            self.leadingAnchor.constraint(equalTo: leadingX.0, constant: leadingX.1).isActive = true
        }
        
        if let trailingX = trailingAnchor{
            self.trailingAnchor.constraint(equalTo: trailingX.0, constant: trailingX.1).isActive = true
        }
    }
    
    public func setAnchorCenterHorizontallyTo(view: UIView, widthAnchor: CGFloat?=nil, heightAnchor: CGFloat?=nil,
                                              topAnchor: (NSLayoutYAxisAnchor,CGFloat)?=nil, bottomAnchor: (NSLayoutYAxisAnchor,CGFloat)?=nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setAnchorConstraintsEqualTo(widthAnchor: widthAnchor, heightAnchor: heightAnchor, centerXAnchor: view.centerXAnchor)
        
        if let topY = topAnchor{
            self.topAnchor.constraint(equalTo: topY.0, constant: topY.1).isActive = true
        }
        
        if let botY = bottomAnchor{
            self.bottomAnchor.constraint(equalTo: botY.0, constant: botY.1).isActive = true
        }
    }
    
    public func setAnchorConstraintsFullSizeTo(view: UIView, margin: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: margin).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
    }
    
    // MARK: - Shadow
    public func setDefaultShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.05
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
    }
    
    //MARK: - General functions
    
    public func addSubviews(_ views: [UIView]) {
        views.forEach({ self.addSubview($0)})
    }
    
    public func setCornerRadius(_ radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    public func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    public func addDismissKeyboardGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer){
        self.endEditing(true)
    }
    
}

