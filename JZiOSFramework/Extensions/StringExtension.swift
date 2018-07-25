//
//  StringExtension.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 23/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation

extension String {
    
    //Mark: - Localization
    
    //Get localized string without variable inside, directly translate
    func localizedWithSetting() -> String {
        return NSLocalizedString(self, bundle: getUserSettingLanguageBundle(), comment: "")
    }
    
    //Get localized string with given format and arguments (variable inside)
    func localizedWithSetting(_ arguments: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, bundle: getUserSettingLanguageBundle(), comment: ""), arguments: arguments)
    }
    
    private func getUserSettingLanguageBundle() -> Bundle {
        if let path = Bundle.main.path(forResource: getSettingLanguage(), ofType: "lproj") {
            return Bundle(path: path)!
        } else {
            return Bundle.main
        }
    }
    
    //Example Function
    func getSettingLanguage() -> String{
        var lang = UserDefaults.standard.string(forKey: "language") ?? Locale.preferredLanguages[0]
        lang = lang.contains("zh-Hans") ? "zh-Hans" : "en"
        return lang
    }
    
    //MARK: Transform
    public func toHTMLParsedAttributedStr(font: UIFont, isJustified: Bool) -> NSMutableAttributedString {
        
        let modifiedFontString = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(font.pointSize)\">%@</span>", self)
        
        do {
            let attributedStr = try NSAttributedString(
                data: modifiedFontString.data(using: .unicode, allowLossyConversion: true)!,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            let attributedText = NSMutableAttributedString(attributedString: attributedStr)
            if isJustified {
                let paragrah = NSMutableParagraphStyle()
                paragrah.alignment = .justified
                paragrah.paragraphSpacing = font.lineHeight
                attributedText.addAttributes([NSAttributedStringKey.paragraphStyle: paragrah], range: NSRange.init(location: 0, length: attributedStr.length))
            }
            return attributedText
        } catch {
            return NSMutableAttributedString(string: "")
        }
    }
    
    public func stringByReplacingFirstOccurrenceOfString(target: String, withString replaceString: String) -> String {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
}
