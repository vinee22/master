//
//  AdminViewController.swift
//  SwiftHire
//
//  Created by HS on 16/03/24.
//

import Foundation
import UIKit

import UIKit

class AdminViewController: UIViewController {
    
    // Array to store candidate details
    var candidateDetails: [CandidateviewDetail] = []
    
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
        
        // Load candidate details (replace this with your logic to fetch candidate details)
        loadCandidateDetails()
        
        // Set up table view delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white // Adjust background color as needed
        
        // Register custom cell if you have one
        tableView.register(CandidateTableViewCell.self, forCellReuseIdentifier: "CandidateCell")
        
        // Set up logout button action
        logoutButton.setTitle("Logout", for: .normal) // Customize logout button text
        logoutButton.setTitleColor(UIColor.blue, for: .normal) // Customize logout button text color
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    // Function to load candidate details (replace this with your own logic to fetch candidate details)
    func loadCandidateDetails() {
        // Example data for demonstration
        candidateDetails = [
            CandidateviewDetail(firstName: "John", lastName: "Doe"),
            CandidateviewDetail(firstName: "Jane", lastName: "Smith")
            // Add more candidate details as needed
        ]
    }
    
    // MARK: - Button Action
    @objc func logoutButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension AdminViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidateDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CandidateCell", for: indexPath) as! CandidateTableViewCell
        
        // Configure the custom cell with candidate details
        let detail = candidateDetails[indexPath.row]
        cell.configure(firstName: detail.firstName, lastName: detail.lastName)
        
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AdminViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle cell selection here, navigate to InterviewDetailsViewController or perform any other action
        let selectedCandidate = candidateDetails[indexPath.row]
        print("Selected candidate: \(selectedCandidate.firstName + selectedCandidate.lastName)")
    }
}

struct CandidateviewDetail {
    let firstName: String
    let lastName: String
    // Add any other properties you need for the candidate details
}
