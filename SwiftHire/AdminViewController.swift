//
//  AdminViewController.swift
//  SwiftHire
//
//  Created by HS on 16/03/24.
//

import Foundation
import UIKit

class AdminViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
    
    var candidateNameTextField = UITextField()
    var interviewTypeTextField = UITextField()
    var interviewTypePicker = UIPickerView()
    var interviewTypeLabels = ["On-Site Interview", "Behavioral Interview", "Technical Interview", "Group Discussion Interview", "Panel Interview", "Phone Interview", "Video Interview", "Assessment Interview"]
    var datePicker = UIDatePicker()
    var timePicker = UIDatePicker()
    var submitButton = UIButton()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Background Image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        // Navigation Bar
        title = AppSettings().adminScreenTitle()
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AppSettings().primaryColor(),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30) // Adjust font size as needed
        ]
        view.backgroundColor = .white
        
        // Load the original images
        guard let logOutImage = UIImage(named: "logoutIcon") else { return }
        let resizedlogOutImage = logOutImage.resized(to: CGSize(width: 30, height: 30))
        let tintedlogOutImage = resizedlogOutImage.withTintColor(AppSettings().primaryColor(), renderingMode: .alwaysOriginal)
        let logOutButton = UIBarButtonItem(image: tintedlogOutImage, style: .plain, target: self, action: #selector(logOutButtonTapped))
        navigationItem.leftBarButtonItem = logOutButton
        
        // Create flexible space item
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        // Create done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        guard let NoticationImage = UIImage(named: "NotificationIcon") else { return }
        
        let resizedNoticationImage = NoticationImage.resized(to: CGSize(width: 30, height: 30))
        
        let tintedNoticationImage = resizedNoticationImage.withTintColor(AppSettings().primaryColor(), renderingMode: .alwaysOriginal)
        
        let noticationButton = UIBarButtonItem(image: tintedNoticationImage, style: .plain, target: self, action: #selector(noticationButtonTapped))
        
        navigationItem.rightBarButtonItem = noticationButton

        // Create toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.items = [flexibleSpace, doneButton]

        // Assign toolbar as input accessory view
        interviewTypeTextField.inputAccessoryView = toolbar

        // Set up UI
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Candidate Name Text Field
        candidateNameTextField.placeholder = "Candidate Name"
        candidateNameTextField.borderStyle = .roundedRect
        view.addSubview(candidateNameTextField)
        
        // Interview Type Text Field
        interviewTypeTextField.placeholder = "Select Interview Types"
        interviewTypeTextField.borderStyle = .roundedRect
        interviewTypeTextField.inputView = interviewTypePicker // Set inputView to show the picker view
        view.addSubview(interviewTypeTextField) // Add text field to the view
        
        // Interview Type Picker
        interviewTypePicker.delegate = self
        interviewTypePicker.dataSource = self
        
        // Date Picker
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = AppSettings().highContrastColor()
        view.addSubview(datePicker)
        
        // Time Picker
        timePicker.datePickerMode = .time
        timePicker.backgroundColor = AppSettings().highContrastColor()
        view.addSubview(timePicker)
        
        // Submit Button
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = AppSettings().primaryColor()
        submitButton.setTitleColor(AppSettings().highContrastColor(), for: .normal)
        submitButton.layer.cornerRadius = 8
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        
        setupConstraints()
    }
    private func setupConstraints() {
        // Candidate Name Text Field Constraints
        candidateNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            candidateNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            candidateNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            candidateNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            candidateNameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Interview Type Text Field Constraints
        interviewTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            interviewTypeTextField.topAnchor.constraint(equalTo: candidateNameTextField.bottomAnchor, constant: 20),
            interviewTypeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            interviewTypeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            interviewTypeTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Date Picker Constraints
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: interviewTypeTextField.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Time Picker Constraints
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Submit Button Constraints
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func submitButtonTapped() {
        // Retrieve data from UI elements
        let candidateName = candidateNameTextField.text ?? ""
        let interviewType = interviewTypeTextField.text ?? ""
        let interviewDate = datePicker.date
        let interviewTime = timePicker.date
        
        // Create an instance of the Admin model
        let admin = Admin(cname: candidateName, interviewtype: interviewType, idate: interviewDate, itime: interviewTime)
        
        // Save the Admin data as needed (e.g., to UserDefaults)
        saveUserToAdminDefaults(admin: admin)
        let alertController = UIAlertController(title: "Success", message: "Interview Scheduled", preferredStyle: .alert)
           
           // Create the OK action
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           
           // Add the OK action to the alert controller
           alertController.addAction(okAction)
           
           // Present the alert controller
           present(alertController, animated: true, completion: nil)
    }

    // Save the Admin data to UserDefaults
    func saveUserToAdminDefaults(admin: Admin) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(admin.cname, forKey: "candidateName")
        userDefaults.set(admin.interviewtype, forKey: "interviewType")
        userDefaults.set(admin.idate, forKey: "interviewDate")
        userDefaults.set(admin.itime, forKey: "interviewTime")
        userDefaults.synchronize()
        
        // Use the properties as needed
        print("Candidate Name: \(admin.getCandidateName())")
        print("Interview Type: \(admin.getInterviewType())")
        print("Interview Date: \(admin.getInterviewDate())")
        print("Interview Time: \(admin.getInterviewTime())")
    }

    
    @objc private func logOutButtonTapped() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to Log Out?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func noticationButtonTapped(_ sender: UIBarButtonItem) {
        if let dashboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController {
            navigationController?.pushViewController(dashboardVC, animated: true)
        }    }
    
    @objc func doneButtonTapped() {
        // Dismiss the keyboard or hide the date picker when the "Done" button is tapped
        interviewTypeTextField.resignFirstResponder()
    }
    // MARK: - UIPickerView Delegate & DataSource Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return interviewTypeLabels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return interviewTypeLabels[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        interviewTypeTextField.text = interviewTypeLabels[row] // Update text field when a row is selected
    }
    
}
