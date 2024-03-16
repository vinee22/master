//
//  EditAccountViewController.swift
//  SwiftHire
//
//  Created by HS on 15/03/24.
//

import Foundation
import UIKit
import UniformTypeIdentifiers

class EditAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate, UITextFieldDelegate {

    // IBOutlet for Image View
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pdfPickerButton: UIButton!
        
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
    var pdfFileNameTextField = UITextField()
    
    // Outlet for the submit button
//    var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Load the original images
        guard let backImage = UIImage(named: "BackIcon") else { return }
        // Resize the back icon image
        let resizedBackImage = backImage.resized(to: CGSize(width: 30, height: 30))
        
        // Tint the resized images
        let tintedBackImage = resizedBackImage.withTintColor(AppSettings().primaryColor(), renderingMode: .alwaysOriginal)
        
        
        // Navigation Bar
        let backButton = UIBarButtonItem(image: tintedBackImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        
        title = AppSettings().profileScreenTitle()
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AppSettings().primaryColor(),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30) // Adjust font size as needed
        ]
        
        // Setup the date picker for "Date of Birth" text field
        setupDatePicker()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
        pdfPickerButton.addTarget(self, action: #selector(pdfPickerButtonTapped(_:)), for: .touchUpInside)
        
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
        emailAddressTextField.layer.cornerRadius = 10
        emailAddressTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(emailAddressTextField)
        
        pdfFileNameTextField.placeholder = AppSettings().pdfPlaceholderText()
        pdfFileNameTextField.tintColor = AppSettings().secondaryColor()
        pdfFileNameTextField.textColor = AppSettings().backgroundColor()
        pdfFileNameTextField.autocapitalizationType = .none
        pdfFileNameTextField.layer.cornerRadius = 10
        pdfFileNameTextField.isUserInteractionEnabled = false
        pdfFileNameTextField.backgroundColor = AppSettings().highContrastColor()
        self.view.addSubview(pdfFileNameTextField)
        
        
        pdfPickerButton.setTitle(AppSettings().selectPDFButtonText(), for: .normal)
        pdfPickerButton.backgroundColor = AppSettings().primaryColor()
        pdfPickerButton.setTitleColor(AppSettings().highContrastColor(), for: .normal)
        pdfPickerButton.layer.cornerRadius = 10
        pdfPickerButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
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
        pdfFileNameTextField.translatesAutoresizingMaskIntoConstraints = false
        pdfPickerButton.translatesAutoresizingMaskIntoConstraints = false
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
               
               pdfFileNameTextField.topAnchor.constraint(equalTo: emailAddressTextField.bottomAnchor, constant: 10),
               pdfFileNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               pdfFileNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               pdfFileNameTextField.heightAnchor.constraint(equalToConstant: 50),
               
               pdfPickerButton.topAnchor.constraint(equalTo: pdfFileNameTextField.bottomAnchor, constant: 20),
               pdfPickerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               pdfPickerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               pdfPickerButton.heightAnchor.constraint(equalToConstant: 50),

               submitButton.topAnchor.constraint(equalTo: pdfPickerButton.bottomAnchor, constant: 20),
               submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               submitButton.heightAnchor.constraint(equalToConstant: 50),
           ])
        
    }
    
    // Function to setup date picker for "Date of Birth" text field
    func setupDatePicker() {
        // Set the date picker mode
        datePicker.datePickerMode = .date
        
        // Add a target to handle date changes
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func backButtonTapped() {
        // Handle back button action
        navigationController?.popViewController(animated: true)
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
            imageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Action method for PDF picker button tap
    @objc func pdfPickerButtonTapped(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf])
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overFullScreen
        present(documentPicker, animated: true, completion: nil)
    }

    // UIDocumentPickerDelegate method to handle selecting PDF documents
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedURL = urls.first else {
            return
        }
        print("Selected PDF URL: \(selectedURL)")
        // Get the PDF file name from the URL
        let fileName = selectedURL.lastPathComponent
        // Update the text field with the PDF file name
        pdfFileNameTextField.text = fileName
    }
    
    // Action method for the submit button
                               @objc func submitButtonTapped() {
                                   // Retrieve data from text fields, image view, and PDF file name text field
                                   let firstName = firstNameTextField.text ?? ""
                                   let lastName = lastNameTextField.text ?? ""
                                   let dateOfBirth = dateOfBirthTextField.text ?? ""
                                   let emailAddress = emailAddressTextField.text ?? ""
                                   let selectedPDFFileName = pdfFileNameTextField.text ?? ""
                                   // Perform actions with the retrieved data, such as storing it or updating the stored details and files

                                   // Show alert
                                   let alert = UIAlertController(title: "Success", message: "Data successfully saved", preferredStyle: .alert)
                                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                   present(alert, animated: true, completion: nil)
                               }

    @objc func doneButtonTapped() {
        // Dismiss the keyboard or hide the date picker when the "Done" button is tapped
        dateOfBirthTextField.resignFirstResponder()
    }
    
}
