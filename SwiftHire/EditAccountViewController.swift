//
//  EditAccountViewController.swift
//  SwiftHire
//
//  Created by HS on 15/03/24.
//

import Foundation
import UIKit

class EditAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate, UITextFieldDelegate {
    
    // IBOutlet for Image View
    @IBOutlet weak var imageView: UIImageView!
    
    var user: Users = Users() // Property to hold the user data
    
    @IBOutlet weak var submitButton: UIButton!
    // Custom date picker for "Date of Birth"
    let datePicker = UIDatePicker()
    
    // Property to hold the name of the selected PDF file
    var selectedPDFFileName: String?
    
    // Outlets for text fields
    var firstNameTextField = UITextField()
    var lastNameTextField = UITextField()
    var dateOfBirthTextField = UITextField()
    var emailAddressTextField = UITextField()
    var passwordTextField = UITextField()
    
    // Outlet for the submit button
    //    var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Navigation Bar
        
        title = AppSettings().profileScreenTitle()
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AppSettings().primaryColor(),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30) // Adjust font size as needed
        ]
        
        // Load the original images
        guard let logOutImage = UIImage(named: "logoutIcon") else { return }
        // Resize the back icon image
        let resizedlogOutImage = logOutImage.resized(to: CGSize(width: 30, height: 30))
        
        // Tint the resized images
        let tintedlogOutImage = resizedlogOutImage.withTintColor(AppSettings().primaryColor(), renderingMode: .alwaysOriginal)
        
        let logOutButton = UIBarButtonItem(image: tintedlogOutImage, style: .plain, target: self, action: #selector(logOutButtonTapped))
        navigationItem.leftBarButtonItem = logOutButton
        
        guard let NoticationImage = UIImage(named: "NotificationIcon") else { return }
        
        let resizedNoticationImage = NoticationImage.resized(to: CGSize(width: 30, height: 30))
        
        let tintedNoticationImage = resizedNoticationImage.withTintColor(AppSettings().primaryColor(), renderingMode: .alwaysOriginal)
        
        let noticationButton = UIBarButtonItem(image: tintedNoticationImage, style: .plain, target: self, action: #selector(noticationButtonTapped))
        
        navigationItem.rightBarButtonItem = noticationButton
        // Setup the date picker for "Date of Birth" text field
        setupDatePicker()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
        //        pdfPickerButton.addTarget(self, action: #selector(pdfPickerButtonTapped(_:)), for: .touchUpInside)
        
        firstNameTextField.placeholder = AppSettings().signupFirstNamePlaceholderText()
        firstNameTextField.borderStyle = .roundedRect
        firstNameTextField.tintColor = AppSettings().secondaryColor()
        firstNameTextField.layer.borderColor = AppSettings().highContrastColor().cgColor
        firstNameTextField.layer.borderWidth = 1
        firstNameTextField.autocorrectionType = .no
        firstNameTextField.layer.cornerRadius = 10
        firstNameTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(firstNameTextField)
        
        
        lastNameTextField.placeholder = AppSettings().signupLastNamePlaceholderText()
        lastNameTextField.borderStyle = .roundedRect
        lastNameTextField.tintColor = AppSettings().secondaryColor()
        lastNameTextField.layer.borderColor = AppSettings().highContrastColor().cgColor
        lastNameTextField.layer.borderWidth = 1
        firstNameTextField.autocorrectionType = .no
        lastNameTextField.layer.cornerRadius = 10
        lastNameTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(lastNameTextField)
        
        dateOfBirthTextField.placeholder = AppSettings().signupDateofBirthPlaceholderText()
        datePicker.datePickerMode = .date
        dateOfBirthTextField.tintColor = AppSettings().secondaryColor()
        datePicker.preferredDatePickerStyle = .wheels
        dateOfBirthTextField.inputView = datePicker
        dateOfBirthTextField.layer.borderColor = AppSettings().highContrastColor().cgColor
        dateOfBirthTextField.layer.borderWidth = 1
        dateOfBirthTextField.layer.cornerRadius = 10
        dateOfBirthTextField.borderStyle = .roundedRect
        dateOfBirthTextField.backgroundColor = AppSettings().highContrastColor()
        dateOfBirthTextField.delegate = self // Set the delegate to self
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        dateOfBirthTextField.inputAccessoryView = toolbar
        self.view.addSubview(dateOfBirthTextField)
        
        emailAddressTextField.placeholder = AppSettings().loginEmailPlaceholderText()
        emailAddressTextField.tintColor = AppSettings().secondaryColor()
        emailAddressTextField.textColor = AppSettings().backgroundColor()
        emailAddressTextField.autocapitalizationType = .none
        emailAddressTextField.borderStyle = .roundedRect
        emailAddressTextField.layer.borderColor = AppSettings().highContrastColor().cgColor
        emailAddressTextField.layer.borderWidth = 1
        emailAddressTextField.isUserInteractionEnabled = false
        emailAddressTextField.layer.cornerRadius = 10
        emailAddressTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(emailAddressTextField)
        
        
        passwordTextField.placeholder = AppSettings().loginPasswordPlaceholderText()
        passwordTextField.tintColor = AppSettings().secondaryColor()
        passwordTextField.textColor = AppSettings().backgroundColor()
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.cornerRadius = 10
//        passwordTextField.isUserInteractionEnabled = false
        passwordTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(passwordTextField)
        
        submitButton.setTitle(AppSettings().submitButtonText(), for: .normal)
        submitButton.backgroundColor = AppSettings().primaryColor()
        submitButton.setTitleColor(AppSettings().highContrastColor(), for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        // Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        dateOfBirthTextField.translatesAutoresizingMaskIntoConstraints = false
        emailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            firstNameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            dateOfBirthTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
            dateOfBirthTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateOfBirthTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateOfBirthTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailAddressTextField.topAnchor.constraint(equalTo: dateOfBirthTextField.bottomAnchor, constant: 10),
            emailAddressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailAddressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailAddressTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailAddressTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            submitButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // Retrieve user data from UserDefaults
        let userDefaults = UserDefaults.standard
        let firstName = userDefaults.string(forKey: "firstName") ?? ""
        let lastName = userDefaults.string(forKey: "lastName") ?? ""
        let email = userDefaults.string(forKey: "email") ?? ""
        let password = userDefaults.string(forKey: "password") ?? ""
        let dob = userDefaults.object(forKey: "dob") as? Date ?? Date()

        // Display user data in labels
        firstNameTextField.text = "\(firstName)"
        lastNameTextField.text = "\(lastName)"
        emailAddressTextField.text = "\(email)"
        passwordTextField.text = "\(password)"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateOfBirthTextField.text = "\(dateFormatter.string(from: dob))"
        
    }
    
    // Function to setup date picker for "Date of Birth" text field
    func setupDatePicker() {
        // Set the date picker mode
        datePicker.datePickerMode = .date
        
        // Add a target to handle date changes
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    // Action method for date picker value changed
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" // Adjust date format as needed
        dateOfBirthTextField.text = dateFormatter.string(from: sender.date)
    }
    
    // Action method for tapping on the image view
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        // Open photo library for image selection
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate method to handle image selection
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage // Set selectedImage as the placeholder image for imageView
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Action method for the submit button
    @objc func submitButtonTapped() {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let email = emailAddressTextField.text,
              let password = passwordTextField.text, !password.isEmpty else {
            submitButton.backgroundColor = AppSettings().lowContrastColor()
            return
        }
        // Perform actions with the retrieved data, such as storing it or updating the stored details and files
        let dob = datePicker.date
        let user = Users(fname: firstName, lname: lastName, email: email, password: password, dob: dob)
        
        saveUserToUserDefaults(user: user)
        // Show alert
        let alert = UIAlertController(title: "Success", message: "Data successfully saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Method to save user data to UserDefaults
    func saveUserToUserDefaults(user: Users) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(user.getFirstName(), forKey: "firstName")
        userDefaults.set(user.getLastName(), forKey: "lastName")
        userDefaults.set(user.getEmail(), forKey: "email")
        userDefaults.set(user.getPassword(), forKey: "password")
        userDefaults.set(user.getDateOfBirth(), forKey: "dob")
        userDefaults.synchronize()
        // Use the properties as needed
        print("First Name: \(user.getFirstName())")
        print("Last Name: \(user.getLastName())")
        print("Email: \(user.getEmail())")
        print("Password: \(user.getPassword())")
        print("Date of Birth: \(user.getDateOfBirth())")
    }
    
    @objc func noticationButtonTapped(_ sender: UIBarButtonItem) {
        if let dashboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController {
            navigationController?.pushViewController(dashboardVC, animated: true)
        }    }
    
    @objc func doneButtonTapped() {
        // Dismiss the keyboard or hide the date picker when the "Done" button is tapped
        dateOfBirthTextField.resignFirstResponder()
    }
    
    @objc func logOutButtonTapped() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to Log Out?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    struct User {
        let firstName: String
        let lastName: String
        let dateOfBirth: String
        let email: String
        let password: String
    }
    
}
