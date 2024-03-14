//
//  SignInSignUpViewController.swift
//  Interview Scheduler
//
//  Created by HS on 13/03/24.
//

import UIKit

class SignInSignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // White Background View
        let whiteBackgroundView = UIView(frame: CGRect(x: 0, y: 600, width: view.frame.width, height: 500))
        whiteBackgroundView.backgroundColor = AppSettings().backgroundColor()
        whiteBackgroundView.layer.cornerRadius = 8
        view.addSubview(whiteBackgroundView)
        
        // Title Label
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 350, width: view.frame.width, height: 50))
        titleLabel.text = AppSettings().signInSignUpTitle()
        titleLabel.textAlignment = .center
        titleLabel.textColor = AppSettings().primaryColor()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        view.addSubview(titleLabel)
        
        // Subtitle Label
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 400, width: view.frame.width, height: 50))
        subtitleLabel.text = AppSettings().signInSignUpDescription()
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = AppSettings().secondaryColor()
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(subtitleLabel)
        
        // Login Button
        let loginButton = UIButton(frame: CGRect(x: 50, y: 650, width: view.frame.width - 100, height: 50))
        loginButton.setTitle(AppSettings().loginButtonText(), for: .normal)
        loginButton.tintColor = AppSettings().highContrastColor()
        loginButton.backgroundColor = AppSettings().primaryColor()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        // signup Button
        let signupButton = UIButton(frame: CGRect(x: 50, y: 720, width: view.frame.width - 100, height: 50))
        signupButton.setTitle(AppSettings().signUpButtonText(), for: .normal)
        signupButton.tintColor = AppSettings().highContrastColor()
        signupButton.backgroundColor = AppSettings().primaryColor()
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        view.addSubview(signupButton)
    }
    
    @objc func loginButtonTapped() {
        // Instantiate the login view controller
        let loginViewController = LoginViewController()
        
        // Push the login view controller onto the navigation stack
        navigationController?.pushViewController(loginViewController, animated: true)
        print("Login button tapped")
    }
    
    @objc func signupButtonTapped() {
        // Instantiate the sign-up view controller
        let signUpViewController = SignUpViewController()
        
        // Push the sign-up view controller onto the navigation stack
        navigationController?.pushViewController(signUpViewController, animated: true)
        print("signup button tapped")
    }
}
