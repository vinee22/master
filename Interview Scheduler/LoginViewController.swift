//
//  LoginViewController.swift
//  Interview Scheduler
//
//  Created by HS on 14/03/24.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    var validationLabel = UILabel() // Declare validationLabel outside of viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImage)
        
        // Load the original images
        guard let backImage = UIImage(named: "BackIcon") else { return }
        guard let homeImage = UIImage(named: "HomeIcon") else { return }
        
        // Resize the back icon image
        let resizedBackImage = backImage.resized(to: CGSize(width: 50, height: 50))
        
        // Resize the home icon image
        let resizedHomeImage = homeImage.resized(to: CGSize(width: 50, height: 50))
        
        // Tint the resized images
        let tintedBackImage = resizedBackImage.withTintColor(AppSettings().primaryColor(), renderingMode: .alwaysOriginal)
        let tintedHomeImage = resizedHomeImage.withTintColor(AppSettings().primaryColor(), renderingMode: .alwaysOriginal)
        
        
        // Navigation Bar
        let backButton = UIBarButtonItem(image: tintedBackImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        // Navigation Home
        let homeButton = UIBarButtonItem(image: tintedHomeImage, style: .plain, target: self, action: #selector(homeButtonTapped))
        navigationItem.rightBarButtonItem = homeButton
        
        title = AppSettings().signUpScreenTitle()
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AppSettings().primaryColor(),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30) // Adjust font size as needed
        ]
        
        // Email Text Field
        let emailTextField = UITextField()
        emailTextField.placeholder = AppSettings().loginEmailPlaceholderText()
        emailTextField.tintColor = AppSettings().secondaryColor()
        emailTextField.textColor = AppSettings().secondaryColor()
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderColor = AppSettings().backgroundColor().cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(emailTextField)
        
        // Add target to monitor changes in the emailTextField
        emailTextField.addTarget(self, action: #selector(validateEmail(_:)), for: .editingChanged)
        
        // Password Text Field
        let passwordTextField = UITextField()
        passwordTextField.placeholder = AppSettings().loginPasswordPlaceholderText()
        passwordTextField.tintColor = AppSettings().secondaryColor()
        passwordTextField.textColor = AppSettings().secondaryColor()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderColor = AppSettings().backgroundColor().cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(passwordTextField)
        
        // Add target to monitor changes in the passwordTextField
        passwordTextField.addTarget(self, action: #selector(validatePassword(_:)), for: .editingChanged)
        
        // Login Button
        let loginButton = UIButton()
        loginButton.setTitle(AppSettings().loginButtonText(), for: .normal)
        loginButton.backgroundColor = AppSettings().primaryColor()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        self.view.addSubview(loginButton)
        
        // Don't have an account Label
        let dontHaveAccountLabel = UILabel()
        dontHaveAccountLabel.text = AppSettings().loginDontHaveAnAccount()
        dontHaveAccountLabel.textColor = AppSettings().secondaryColor()
        dontHaveAccountLabel.backgroundColor = AppSettings().primaryColor()
        dontHaveAccountLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dontHaveAccountLabelTapped))
        dontHaveAccountLabel.addGestureRecognizer(tapGesture)
        self.view.addSubview(dontHaveAccountLabel)
        
        // Layout
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        dontHaveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100), // Adjust the constant as needed
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            dontHaveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dontHaveAccountLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        
    }
    
    @objc func backButtonTapped() {
        // Handle back button action
        navigationController?.popViewController(animated: true)
    }
    
    @objc func homeButtonTapped() {
        // Handle home button action
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func validateEmail(_ textField: UITextField) {
        guard let email = textField.text else { return }
        
        // Perform email validation using a regular expression
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isEmailValid = emailPredicate.evaluate(with: email)
        
        // Update validation message label visibility based on the validation result
        if isEmailValid {
            textField.layer.borderColor = UIColor.green.cgColor
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    
    @objc func validatePassword(_ textField: UITextField) {
        guard let password = textField.text else { return }
        
        // Perform password validation
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[@*$#]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let isPasswordValid = passwordPredicate.evaluate(with: password)
        
        // Update validation message label visibility based on the validation result
        
        if isPasswordValid {
            textField.layer.borderColor = UIColor.green.cgColor
        } else {
            // Password does not meet the criteria
            // For example, change the border color to red to indicate validation failure
            textField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @objc func loginButtonTapped() {
        // Handle login button action
        print("Login button tapped")
    }
    
    @objc func dontHaveAccountLabelTapped() {
        // Navigate to another view controller for new account registration
        let registerViewController = SignUpViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}
