//
//  JZAlertController.swift
//  JZFramework
//
//  Created by Jeff Zhang on 16/4/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//


/** Examples of usage
public static func showHyperLinkAlertController(message: String, linkAddress: String, linkText: String) {
    let customView = HyperlinkAlertView(text: message, linkAddress: linkAddress, linkText: linkText)
    let alertController = JZAlertController(customView: customView)
    let OKAction = CustomAlertAction(title: "OK")
    alertController.addAction(OKAction)
    BaseViewControllerUtil.getCurrentViewController()?.present(alertController, animated: true)
}
 */

import UIKit

fileprivate let fontSize: CGFloat = 16

///Custom Alert Controller by providing custom view and actions
public class JZAlertController: UIViewController {
    
    let alertView = UIView()
    lazy var stvAlert = UIStackView()
    let customView: UIView
    let stvActions = UIStackView()
    
    let actionButtonHeight: CGFloat = 44
    let alertViewWidth: CGFloat = 280
    let dividerColor = UIColor.gray.withAlphaComponent(0.2)
    let dividerThickness: CGFloat = 1
    
    init(customView: UIView) {
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
        
        setupBasic()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBasic() {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        alertView.setCornerRadius(10)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        alertView.addSubview(blurEffectView)
        blurEffectView.setAnchorConstraintsFullSizeTo(view: alertView)
        alertView.backgroundColor = .clear
        stvAlert.axis = .vertical
        stvAlert.addArrangedSubviews([customView, getDefaultDivider(false), stvActions])
        alertView.addSubview(stvAlert)
        stvAlert.setAnchorConstraintsFullSizeTo(view: alertView)
        view.addSubview(alertView)
        alertView.setAnchorConstraintsEqualTo(widthAnchor: alertViewWidth, centerXAnchor: view.centerXAnchor, centerYAnchor: view.centerYAnchor)
    }
    
    public func addAction(_ action: CustomAlertAction) {
        
        let subviewsCount = stvActions.arrangedSubviews.count
        
        if subviewsCount == 3 {
            let currentSubviews = stvActions.arrangedSubviews
            stvActions.resetArrangedSubviews([currentSubviews.first!, getDefaultDivider(false), currentSubviews.last!])
            stvActions.axis = .vertical
        }
        
        if subviewsCount >= 3 {
            stvActions.addArrangedSubview(getDefaultDivider(false))
        }
        
        let actionButton = UIButton.getDefaultButton(title: action.title, font: UIFont.getRegularText(fontSize), titleColor: action.titleColor, backgroundColor: .clear)
        actionButton.heightAnchor.constraint(equalToConstant: actionButtonHeight).isActive = true
        let action = action._handler == nil ? #selector(defaultHandler) : #selector(action.handler)
        actionButton.addTarget(self, action: action, for: .touchUpInside)
        
        if subviewsCount == 1 {
            stvActions.distribution = .fill
            stvActions.addArrangedSubviews([getDefaultDivider(true), actionButton])
            stvActions.arrangedSubviews.first!.widthAnchor.constraint(equalTo: actionButton.widthAnchor).isActive = true
        } else {
            stvActions.addArrangedSubview(actionButton)
        }
    }
    
    @objc private func defaultHandler() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getDefaultDivider(_ isHorizontal: Bool) -> UIView {
        let divider = UIView(backgroundColor: dividerColor)
        let dividerAnchor = isHorizontal ? divider.widthAnchor : divider.heightAnchor
        dividerAnchor.constraint(equalToConstant: dividerThickness).isActive = true
        return divider
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

public class CustomAlertAction {
    
    public var title: String
    public var titleColor: UIColor?
    public var _handler: (() -> Void)?
    
    init(title: String, titleColor: UIColor? = nil, handler: (() -> Void)? = nil) {
        self.title = title
        self.titleColor = titleColor
        self._handler = handler
    }
    
    @objc public func handler() {
        if let handlerAction = _handler {
            handlerAction()
        }
    }
    
}


public class HyperlinkAlertView: UIView {
    
    var text: String
    var linkAddress: String
    var linkText: String
    lazy var tvText: BaseTextView = BaseTextView(text: "")
    let padding: CGFloat = 15
    
    public init(text: String, linkAddress: String, linkText: String) {
        self.text = text
        self.linkAddress = linkAddress
        self.linkText = linkText
        super.init(frame: .zero)
        
        setupBasic()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBasic() {
        tvText.isScrollEnabled = false
        tvText.isEditable = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let wholeAttributes = [NSAttributedStringKey.font: UIFont.getSemiboldText(fontSize),
                               NSAttributedStringKey.paragraphStyle: paragraphStyle]
        let linkAttributes = [NSAttributedStringKey.link: URL(string: linkAddress)!,
                              NSAttributedStringKey.foregroundColor: UIColor.blue] as [NSAttributedStringKey : Any]
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttributes(linkAttributes, range: NSString(string: text).range(of: linkText))
        attributedStr.addAttributes(wholeAttributes, range: NSRange(location: 0, length: attributedStr.length))
        tvText.attributedText = attributedStr
        self.addSubview(tvText)
        tvText.setAnchorConstraintsFullSizeTo(view: self, padding: padding)
    }
}


