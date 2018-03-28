//
//  CopyableLabel.swift
//  JZFramework
//
//  Created by Jeff Zhang on 14/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

//Simulator will cause first time long press flickering bug
open class CopyableLabel: UILabel {
    
    public init(text: String?=nil, font: UIFont?=nil, textColor: UIColor?=nil) {
        super.init(frame: .zero)
        
        self.text = text ?? ""
        self.font = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize) 
        self.textColor = textColor ?? UIColor.black
        setupBasic()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBasic()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupBasic() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenu)))
        NotificationCenter.default.addObserver(self, selector: #selector(clearColor),name: NSNotification.Name.UIMenuControllerWillHideMenu, object: nil)
    }
    
    @objc private func clearColor() {
        let attribute = [NSAttributedStringKey.backgroundColor: UIColor.clear]
        self.attributedText = NSAttributedString(string: self.text!, attributes: attribute)
    }
    
    @objc private func showMenu(_ sender: AnyObject?) {
        
        let copyMenu = UIMenuController.shared
        guard !copyMenu.isMenuVisible else {return}
        
        let attribute = [NSAttributedStringKey.backgroundColor: UIColor(hex: 0xB9B9B9)]
        let attributedString = NSAttributedString(string: self.text!, attributes: attribute)
        self.attributedText = attributedString
        becomeFirstResponder()
        
        //menu position depends on the length of the text
        let stringWidth = BaseLabel.getLabelWidth(text: self.text!, font: self.font, height: self.bounds.height)
        
        if stringWidth < self.bounds.width {
            var newBounds:CGRect!
            
            if textAlignment == .right {
                newBounds = CGRect(x: bounds.width - stringWidth, y: bounds.origin.y, width: stringWidth, height: bounds.height)
            } else if textAlignment == .center {
                newBounds = CGRect(x: 1/2*(bounds.width - stringWidth), y: bounds.origin.y, width: stringWidth, height: bounds.height)
                
                // Left Natrual Justified
            } else {
                newBounds = CGRect(origin: bounds.origin, size: CGSize(width: stringWidth, height: bounds.height))
            }
            copyMenu.setTargetRect(newBounds, in: self)
            
        } else {
            copyMenu.setTargetRect(bounds, in: self)
        }
        copyMenu.setMenuVisible(true, animated: true)
    }
    
    open override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = text
        UIMenuController.shared.setMenuVisible(false, animated: false)
    }
    
    open override var canBecomeFirstResponder : Bool {
        return true
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy) {
            return true
        }
        return false
    }
}
