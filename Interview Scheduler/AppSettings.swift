//
//  AppSettings.swift
//  Interview Scheduler
//
//  Created by HS on 13/03/24.
//

import Foundation
import UIKit

class AppSettings {
    var settingData: NSDictionary?
    
    init() {
        settingData = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Settings", ofType: "plist") ?? "") as? [String: Any] as NSDictionary?
    }
    
    func signInSignUpTitle() -> String {
        guard let setting = settingData?["SignInSignUpTitle"] as? String else {
            return "" }
            return setting
        }

    func signInSignUpDescription() -> String {
        guard let setting = settingData?["SignInSignUpDescription"] as? String else {
            return "" }
            return setting
        }
    
    func loginButtonText() -> String {
        guard let setting = settingData?["LoginButtonText"] as? String else {
            return "" }
            return setting
        }
    
    func signUpButtonText() -> String {
        guard let setting = settingData?["SignUpButtonText"] as? String else {
            return "" }
            return setting
        }
    
    func loginScreenTitle() -> String {
        guard let setting = settingData?["LoginScreenTitle"] as? String else {
            return "" }
            return setting
        }
    
    func signUpScreenTitle() -> String {
        guard let setting = settingData?["SignUpScreenTitle"] as? String else {
            return "" }
            return setting
        }
    
    func loginEmailPlaceholderText() -> String {
        guard let setting = settingData?["LoginEmailPlaceholderText"] as? String else {
            return "" }
            return setting
        }
    
    func loginPasswordPlaceholderText() -> String {
        guard let setting = settingData?["LoginPasswordPlaceholderText"] as? String else {
            return "" }
            return setting
        }
    
    func loginDontHaveAnAccount() -> String {
        guard let setting = settingData?["LoginDontHaveAnAccount"] as? String else {
            return "" }
            return setting
        }
    
    func signupFirstNamePlaceholderText() -> String {
        guard let setting = settingData?["SignupFirstNamePlaceholderText"] as? String else {
            return "" }
            return setting
        }
    
    func signupLastNamePlaceholderText() -> String {
        guard let setting = settingData?["SignupLastNamePlaceholderText"] as? String else {
            return "" }
            return setting
        }
    
    func signupDateofBirthPlaceholderText() -> String {
        guard let setting = settingData?["SignupDateofBirthPlaceholderText"] as? String else {
            return "" }
            return setting
        }
    
    func signupEmailPlaceholderText() -> String {
        guard let setting = settingData?["SignupEmailPlaceholderText"] as? String else {
            return "" }
            return setting
        }
    
    func signupPasswordPlaceholderText() -> String {
        guard let setting = settingData?["SignupPasswordPlaceholderText"] as? String else {
            return "" }
            return setting
        }
    
    func signupConfirmPasswordPlaceholderText() -> String {
        guard let setting = settingData?["SignupConfirmPasswordPlaceholderText"] as? String else {
            return "" }
            return setting
        }
    
    func signupAlreadyHaveAnAccountText() -> String {
        guard let setting = settingData?["SignupAlreadyHaveAnAccountText"] as? String else {
            return "" }
            return setting
        }
    
    func primaryColor() -> UIColor {
        let setting = settingData?["PrimaryColor"] as? String ?? ""
        guard let color = UIColor(hexString: setting) else {
            fatalError("Invalid hex string for PrimaryColor: \(setting)")
        }
        return color
    }
    
    func secondaryColor() -> UIColor {
        let setting = settingData?["SecondaryColor"] as? String ?? ""
        guard let color = UIColor(hexString: setting) else {
            fatalError("Invalid hex string for SecondaryColor: \(setting)")
        }
        return color
    }
    
    func backgroundColor() -> UIColor {
        let setting = settingData?["BackgroundColor"] as? String ?? ""
        guard let color = UIColor(hexString: setting) else {
            fatalError("Invalid hex string for BackgroundColor: \(setting)")
        }
        return color
    }
    
    func lowContrastColor() -> UIColor {
        let setting = settingData?["LowContrastColor"] as? String ?? ""
        guard let color = UIColor(hexString: setting) else {
            fatalError("Invalid hex string for LowContrastColor: \(setting)")
        }
        return color
    }
    
    func highContrastColor() -> UIColor {
        let setting = settingData?["HighContrastColor"] as? String ?? ""
        guard let color = UIColor(hexString: setting) else {
            fatalError("Invalid hex string for highContrastColor: \(setting)")
        }
        return color
    }

}

extension UIColor {
    convenience init?(hexString: String) {
        var hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        
        guard hexString.count == 6 else {
            return nil
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
