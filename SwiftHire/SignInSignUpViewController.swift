//
//  SignInSignUpViewController.swift
//  Interview Scheduler
//
//  Created by HS on 13/03/24.
//

import UIKit

class SignInSignUpViewController: UIViewController {
    
    
    var loginButton = UIButton()
    var signupButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // White Background View
        let whiteBackgroundView = UIView(frame: CGRect(x: 0, y: 500, width: view.frame.width, height: 500))
        whiteBackgroundView.backgroundColor = AppSettings().highContrastColor()
        whiteBackgroundView.layer.cornerRadius = 10
        view.addSubview(whiteBackgroundView)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 700))
        imageView.image = UIImage(named: "HeroImage")
        view.addSubview(imageView)

        
        // Login Button
        loginButton = UIButton(frame: CGRect(x: 50, y: 750, width: view.frame.width - 100, height: 50))
        loginButton.setTitle(AppSettings().loginButtonText(), for: .normal)
        loginButton.tintColor = AppSettings().highContrastColor()
        loginButton.backgroundColor = AppSettings().primaryColor()
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        // signup Button
        signupButton = UIButton(frame: CGRect(x: 50, y: 830, width: view.frame.width - 100, height: 50))
        signupButton.setTitle(AppSettings().signUpButtonText(), for: .normal)
        signupButton.tintColor = AppSettings().highContrastColor()
        signupButton.layer.cornerRadius = 10
        signupButton.backgroundColor = AppSettings().primaryColor()
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        view.addSubview(signupButton)
    }
    
    @objc func loginButtonTapped() {
        if let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            navigationController?.pushViewController(loginViewController, animated: true)
        }
        print("Login button tapped")
    }
    
    @objc func signupButtonTapped() {
        if let signUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            navigationController?.pushViewController(signUpViewController, animated: true)
        }
        print("signup button tapped")
    }
    
    func navigateToNextViewController() {
        var nextViewController = UIViewController()
        if loginButton.isSelected{
            nextViewController = LoginViewController()
        }else {
            nextViewController = SignUpViewController()
        }
        let customPushAnimator = CustomPushAnimator()
        navigationController?.delegate = customPushAnimator as? any UINavigationControllerDelegate
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

