//
//  SignUpViewController.swift
//  Interview Scheduler
//
//  Created by HS on 14/03/24.
//

import Foundation
import UIKit
import CoreData

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    let dobTextField = UITextField()
    var passwordTextField = UITextField()
    var firstNameTextField = UITextField()
    var lastNameTextField = UITextField()
    var datePicker = UIDatePicker()
    var emailTextField = UITextField()
    var signUpButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImage)
        
        // White Background View
        let whiteBackgroundView = UIView()
        whiteBackgroundView.backgroundColor = .white
        self.view.addSubview(whiteBackgroundView)
        self.view.sendSubviewToBack(whiteBackgroundView)
        
        // Load the original images
        guard let backImage = UIImage(named: "BackIcon") else { return }
        guard let homeImage = UIImage(named: "HomeIcon") else { return }
        
        // Resize the back icon image
        let resizedBackImage = backImage.resized(to: CGSize(width: 30, height: 30))
        
        // Resize the home icon image
        let resizedHomeImage = homeImage.resized(to: CGSize(width: 30, height: 30))
        
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
        
        // First Name Text Field
        firstNameTextField.placeholder = AppSettings().signupFirstNamePlaceholderText()
        firstNameTextField.borderStyle = .roundedRect
        firstNameTextField.tintColor = AppSettings().secondaryColor()
        firstNameTextField.layer.borderColor = AppSettings().highContrastColor().cgColor
        firstNameTextField.layer.borderWidth = 1
        firstNameTextField.autocorrectionType = .no
        firstNameTextField.layer.cornerRadius = 10
        firstNameTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(firstNameTextField)
        
        firstNameTextField.addTarget(self, action: #selector(validateFirstName(_:)), for: .editingChanged)
        // Last Name Text Field
        
        lastNameTextField.placeholder = AppSettings().signupLastNamePlaceholderText()
        lastNameTextField.borderStyle = .roundedRect
        lastNameTextField.tintColor = AppSettings().secondaryColor()
        lastNameTextField.layer.borderColor = AppSettings().highContrastColor().cgColor
        lastNameTextField.layer.borderWidth = 1
        firstNameTextField.autocorrectionType = .no
        lastNameTextField.layer.cornerRadius = 10
        lastNameTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(lastNameTextField)
        
        lastNameTextField.addTarget(self, action: #selector(validateLastName(_:)), for: .editingChanged)
        
        // Date of Birth Text Field
        dobTextField.placeholder = AppSettings().signupDateofBirthPlaceholderText()
        datePicker.datePickerMode = .date
        dobTextField.tintColor = AppSettings().secondaryColor()
        datePicker.preferredDatePickerStyle = .wheels
        dobTextField.inputView = datePicker
        dobTextField.layer.borderColor = AppSettings().highContrastColor().cgColor
        dobTextField.layer.borderWidth = 1
        dobTextField.layer.cornerRadius = 10
        dobTextField.borderStyle = .roundedRect
        dobTextField.backgroundColor = AppSettings().highContrastColor()
        dobTextField.delegate = self // Set the delegate to self
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        dobTextField.inputAccessoryView = toolbar
        self.view.addSubview(dobTextField)
        
        dobTextField.addTarget(self, action: #selector(validateDob(_:)), for: .editingDidEnd)
        
        // Email Text Field
        emailTextField.placeholder = AppSettings().loginEmailPlaceholderText()
        emailTextField.tintColor = AppSettings().secondaryColor()
        emailTextField.textColor = AppSettings().backgroundColor()
        emailTextField.autocapitalizationType = .none
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderColor = AppSettings().highContrastColor().cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 10
        emailTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(emailTextField)
        
        emailTextField.addTarget(self, action: #selector(validateEmail(_:)), for: .editingChanged)
        
        
        // Password Text Field
        passwordTextField = UITextField()
        passwordTextField.placeholder = AppSettings().signupPasswordPlaceholderText()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderColor = AppSettings().highContrastColor().cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.smartDashesType = .no
        passwordTextField.smartQuotesType = .no
        passwordTextField.smartInsertDeleteType = .no
        passwordTextField.spellCheckingType = .no
        passwordTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(passwordTextField)
        
        passwordTextField.addTarget(self, action: #selector(validatePassword(_:)), for: .editingChanged)
        
        
        // Confirm Password Text Field
        let confirmPasswordTextField = UITextField()
        confirmPasswordTextField.placeholder = AppSettings().signupConfirmPasswordPlaceholderText()
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.layer.borderColor = AppSettings().highContrastColor().cgColor
        confirmPasswordTextField.layer.borderWidth = 1
        confirmPasswordTextField.smartDashesType = .no
        confirmPasswordTextField.smartQuotesType = .no
        confirmPasswordTextField.smartInsertDeleteType = .no
        confirmPasswordTextField.spellCheckingType = .no
        confirmPasswordTextField.layer.cornerRadius = 10
        confirmPasswordTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(confirmPasswordTextField)
        
        confirmPasswordTextField.addTarget(self, action: #selector(validateConfirmPassword(_:)), for: .editingChanged)
        
        
        // Sign Up Button
        signUpButton.setTitle(AppSettings().signUpButtonText(), for: .normal)
        signUpButton.backgroundColor = AppSettings().primaryColor()
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        self.view.addSubview(signUpButton)
        
        // Already have an account Label
        let alreadyHaveAccountLabel = UILabel()
        alreadyHaveAccountLabel.text = AppSettings().signupAlreadyHaveAnAccountText()
        alreadyHaveAccountLabel.textColor = AppSettings().backgroundColor()
        alreadyHaveAccountLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(alreadyHaveAccountLabelTapped))
        alreadyHaveAccountLabel.addGestureRecognizer(tapGesture)
        self.view.addSubview(alreadyHaveAccountLabel)
        
        
        // Layout
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        dobTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        alreadyHaveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        whiteBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),

            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),

            dobTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
            dobTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dobTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dobTextField.heightAnchor.constraint(equalToConstant: 50),

            emailTextField.topAnchor.constraint(equalTo: dobTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),

            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            whiteBackgroundView.topAnchor.constraint(equalTo: firstNameTextField.topAnchor, constant: -10),
            whiteBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteBackgroundView.bottomAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 10),
            
            alreadyHaveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alreadyHaveAccountLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dobTextField {
            let datePicker = textField.inputView as! UIDatePicker
            // Handle the case where the dobTextField is double-clicked to open the date picker
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            textField.text = dateFormatter.string(from: datePicker.date)
            datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // Update the dobTextField with the selected date from the date picker
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dobTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func backButtonTapped() {
        // Handle back button action
        navigationController?.popViewController(animated: true)
    }
    
    @objc func homeButtonTapped() {
        // Handle home button action
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func validateFirstName(_ textField: UITextField) {
        guard let firstName = firstNameTextField.text else { return }
        
        // Check if firstName is empty
        let isFirstNameEmpty = firstName.isEmpty
        
        // Update validation message label visibility based on the validation result
        if isFirstNameEmpty {
            firstNameTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            firstNameTextField.layer.borderColor = UIColor.green.cgColor
        }
    }

    @objc func validateLastName(_ textField: UITextField) {
        guard let lastName = lastNameTextField.text else { return }
        
        // Check if firstName is empty
        let isLastNameEmpty = lastName.isEmpty
        
        // Update validation message label visibility based on the validation result
        if isLastNameEmpty {
            lastNameTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            lastNameTextField.layer.borderColor = UIColor.green.cgColor
        }
    }

    @objc func validateDob(_ textField: UITextField) {
        guard let dob = dobTextField.text else { return }
        
        // Check if firstName is empty
        let isDobEmpty = dob.isEmpty
        
        // Update validation message label visibility based on the validation result
        if isDobEmpty {
            dobTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            dobTextField.layer.borderColor = UIColor.green.cgColor
        }
    }

    
    @objc func validateEmail(_ textField: UITextField) {
        guard let email = emailTextField.text else { return }
        
        // Perform email validation using a regular expression
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isEmailValid = emailPredicate.evaluate(with: email)
        
        // Update validation message label visibility based on the validation result
        if isEmailValid {
            emailTextField.layer.borderColor = UIColor.green.cgColor
        } else {
            emailTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @objc func validatePassword(_ textField: UITextField) {
        guard let password = passwordTextField.text else { return }
        
        // Perform password validation
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[@*$#]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let isPasswordValid = passwordPredicate.evaluate(with: password)
        
        // Update validation message label visibility based on the validation result
        
        if isPasswordValid {
            passwordTextField.layer.borderColor = UIColor.green.cgColor
        } else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @objc func validateConfirmPassword(_ textField: UITextField) {
        guard let confirmPassword = textField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        // Check if confirmPassword matches the password
        let isPasswordMatch = confirmPassword == password
        
        // Update validation message label visibility based on the validation result
        if isPasswordMatch {
            textField.layer.borderColor = UIColor.green.cgColor
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @objc func signUpButtonTapped() {
        // Validate user input
        if let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let dateOfBirth = dobTextField.text, !dateOfBirth.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty{
            signUpButton.backgroundColor = AppSettings().primaryColor()
        } else {
            signUpButton.backgroundColor = AppSettings().lowContrastColor()
            return
        }
        
        // Create a User object
//        let user = User(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, email: email, password: password)
        
        // Save user to CoreData
//        if saveUserToCoreData(user: user) {
//            // Successfully saved user, navigate to DashboardViewController
            navigateToDashboard()
//        } else {
//            // Failed to save user, handle the error appropriately
//            print("Failed to save user")
//        }
    }

    func navigateToDashboard() {
        if let dashboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController {
            navigationController?.pushViewController(dashboardVC, animated: true)
        }
    }

    func saveUserToCoreData(user: User) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: managedContext) else {
            return false
        }
        
        let userObject = NSManagedObject(entity: entity, insertInto: managedContext)
        userObject.setValue(user.firstName, forKey: "firstName")
        userObject.setValue(user.lastName, forKey: "lastName")
        userObject.setValue(user.dateOfBirth, forKey: "dateOfBirth")
        userObject.setValue(user.email, forKey: "email")
        userObject.setValue(user.password, forKey: "password")
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }

    struct User {
        let firstName: String
        let lastName: String
        let dateOfBirth: String
        let email: String
        let password: String
    }

    
    @objc func alreadyHaveAccountLabelTapped() {
        if let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
    
    @objc func doneButtonTapped() {
        // Dismiss the keyboard or hide the date picker when the "Done" button is tapped
        dobTextField.resignFirstResponder()
    }
    
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
