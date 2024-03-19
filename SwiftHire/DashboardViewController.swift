//
//  DashboardViewController.swift
//  SwiftHire
//
//  Created by HS on 14/03/24.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    
    var nameLabel: UILabel!
    var typeLabel: UILabel!
    var dateLabel: UILabel!
    
    var interviewDetails: [Admin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Load interview details
        loadInterviewDetails()
        
        // Create and configure labels
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        typeLabel = UILabel()
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(typeLabel)
        
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        
        // Display interview details in labels
//        if let admin = interviewDetails.first {
//            nameLabel.text = "Name: \(admin.getCandidateName())"
//            typeLabel.text = "Type: \(admin.getInterviewType())"
//            dateLabel.text = "Date: \(admin.getInterviewDate()) \(admin.getInterviewTime())"
//        }
        // Retrieve user data from UserDefaults
        let userDefaults = UserDefaults.standard
        let candidateName = userDefaults.string(forKey: "candidateName") ?? ""
        let interviewType = userDefaults.string(forKey: "interviewType") ?? ""
        let interviewDate = userDefaults.string(forKey: "interviewDate") ?? ""

        // Display user data in labels
        nameLabel.text = "Candiadte Name:\(candidateName)"
        typeLabel.text = "Interview Type:\(interviewType)"
        dateLabel.text = "Interview Date:\(interviewDate)"
        
        // Load the original images
        guard let backImage = UIImage(named: "BackIcon") else { return }
        let resizedBackImage = backImage.resized(to: CGSize(width: 30, height: 30))
        let tintedBackImage = resizedBackImage.withTintColor(AppSettings().primaryColor(), renderingMode: .alwaysOriginal)
        let backButton = UIBarButtonItem(image: tintedBackImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        title = AppSettings().dashboardTitleText()
        
        // Setup constraints for labels
        setupConstraints()
    }
    
    // Function to load interview details
    func loadInterviewDetails() {
        // Retrieve interview details from UserDefaults or any other data source
        if let adminData = UserDefaults.standard.data(forKey: "adminData"),
           let savedAdmin = try? JSONDecoder().decode(Admin.self, from: adminData) {
            interviewDetails.append(savedAdmin)
        }
    }
    
    @objc func backButtonTapped() {
        // Handle back button action
        navigationController?.popViewController(animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
