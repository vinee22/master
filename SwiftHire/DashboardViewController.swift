//
//  DashboardViewController.swift
//  SwiftHire
//
//  Created by HS on 14/03/24.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    
    // Array to store interview details
    var interviewDetails: [InterviewDetail] = []
    
    // Outlet for the table view

    @IBOutlet weak var tableView: UITableView!
    
    // Outlet for the logout button
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Load interview details (replace this with your logic to fetch interview details)
        loadInterviewDetails()
        
        // Load the original images
        guard let backImage = UIImage(named: "BackIcon") else { return }
        // Resize the back icon image
        let resizedBackImage = backImage.resized(to: CGSize(width: 30, height: 30))
        
        // Tint the resized images
        let tintedBackImage = resizedBackImage.withTintColor(AppSettings().primaryColor(), renderingMode: .alwaysOriginal)
        
        let backButton = UIBarButtonItem(image: tintedBackImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
//        guard let editImage = UIImage(named: "EditIcon") else { return }
//
//        let resizedEditImage = editImage.resized(to: CGSize(width: 50, height: 50))
//
//        let tintedEditImage = resizedEditImage.withTintColor(AppSettings().primaryColor(), renderingMode: .alwaysOriginal)
        // Create a UIBarButtonItem with an edit icon
//        let editButton = UIBarButtonItem(image: tintedEditImage, style: .plain, target: self, action: #selector(editButtonTapped))
        
        // Set the edit button as the right bar button item
//        navigationItem.rightBarButtonItem = editButton
        // Set table view delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = AppSettings().primaryColor()
        tableView.layer.borderColor = AppSettings().primaryColor().cgColor
        tableView.layer.borderWidth = 10
        tableView.layer.cornerRadius = 10
        title = AppSettings().dashboardTitleText()
        
        // Register custom cell if you have one
        tableView.register(InterviewCell.self, forCellReuseIdentifier: "InterviewCell")
        
        // Set up logout button action
//        logoutButton.setTitle(AppSettings().logoutButtonText(), for: .normal)
//        logoutButton.setTitleColor(AppSettings().primaryColor(), for: .normal)
//        logoutButton.backgroundColor = AppSettings().highContrastColor()
//        logoutButton.layer.cornerRadius = 10
//        logoutButton.isUserInteractionEnabled = true
//        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    // Function to load interview details (replace this with your own logic to fetch interview details)
    func loadInterviewDetails() {
        // Example data for demonstration
        interviewDetails = [
            InterviewDetail(type: "Phone Interview", date: "March 20, 2024"),
            InterviewDetail(type: "On-site Interview", date: "April 5, 2024")
            // Add more interview details as needed
        ]
    }
    
    @objc func backButtonTapped() {
        // Handle back button action
        navigationController?.popViewController(animated: true)
    }
//    // MARK: - Button Action
//    @objc func logoutButtonTapped() {
//        navigationController?.popToRootViewController(animated: true)
//    }
    
//    @objc func editButtonTapped(_ sender: UIBarButtonItem) {
//        if let dashboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditAccountViewController") as? EditAccountViewController {
//            navigationController?.pushViewController(dashboardVC, animated: true)
//        }    }
}

// MARK: - UITableViewDataSource
extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interviewDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InterviewCell", for: indexPath) as! InterviewCell
        
        // Configure the custom cell with interview details
        let detail = interviewDetails[indexPath.row]
        cell.typeLabel.text = detail.type
        cell.dateLabel.text = detail.date

        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - UITableViewDelegate
extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle cell selection here, navigate to InterviewDetailsViewController or perform any other action
        let selectedDetail = interviewDetails[indexPath.row]
        print("Selected interview type: \(selectedDetail.type)")
    
    }
}

struct InterviewDetail {
    let type: String
    let date: String
}
