//
//  StringExtension.swift
//  JZFramework
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
    
}
