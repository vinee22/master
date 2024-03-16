//
//  InterviewTableViewCell.swift
//  SwiftHire
//
//  Created by HS on 16/03/24.
//

import Foundation
import UIKit

class CandidateTableViewCell: UITableViewCell {
    
    // UI elements for the cell
    let firstNameLabel = UILabel()
    let lastNameLabel = UILabel()
    let interviewTypeDropdown = UIPickerView()
    let interviewDatePicker = UIDatePicker()
    let dottedLineView = UIView() // Dotted line view
    
    // Array to store interview types
    let interviewTypes = ["On-Site Interview", "Behavioral Interview", "Technical Interview", "Group Discussion Interview", "Panel Interview", "Phone Interview", "Video Interview", "Assessment Interview"]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupDottedLine()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupDottedLine()
    }

    private func setupUI() {
        // Configure UI elements
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(interviewTypeDropdown)
        contentView.addSubview(interviewDatePicker)

        firstNameLabel.textColor = AppSettings().primaryColor()
        firstNameLabel.font = UIFont.systemFont(ofSize: 30)
        lastNameLabel.textColor = AppSettings().primaryColor()
        lastNameLabel.font = UIFont.systemFont(ofSize: 15)
        
        // Set up interview type dropdown
        interviewTypeDropdown.translatesAutoresizingMaskIntoConstraints = false
        interviewTypeDropdown.backgroundColor = .white // Customize as needed
        interviewTypeDropdown.delegate = self
        interviewTypeDropdown.dataSource = self

        // Set up interview date picker
        interviewDatePicker.translatesAutoresizingMaskIntoConstraints = false
        interviewDatePicker.datePickerMode = .date
        // Add target action for date change if needed
        
        // Positioning constraints for interviewTypeDropdown
        NSLayoutConstraint.activate([
            interviewTypeDropdown.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 8),
            interviewTypeDropdown.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            interviewTypeDropdown.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            interviewTypeDropdown.heightAnchor.constraint(equalToConstant: 100), // Adjust height as needed
        ])

        // Positioning constraints for interviewDatePicker
        NSLayoutConstraint.activate([
            interviewDatePicker.topAnchor.constraint(equalTo: interviewTypeDropdown.bottomAnchor, constant: 8),
            interviewDatePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            interviewDatePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            interviewDatePicker.heightAnchor.constraint(equalToConstant: 100), // Adjust height as needed
        ])
  
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            firstNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 4),
            lastNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lastNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lastNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    private func setupDottedLine() {
        // Add dotted line view
        dottedLineView.backgroundColor = .clear
        dottedLineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dottedLineView)

        // Create a dashed border
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineDashPattern = [5, 5] // Adjust the pattern as needed
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: bounds.width, y: 0)])
        shapeLayer.path = path
        dottedLineView.layer.addSublayer(shapeLayer)

        // Add constraints for the dotted line view
        NSLayoutConstraint.activate([
            dottedLineView.centerYAnchor.constraint(equalTo: contentView.bottomAnchor),
            dottedLineView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dottedLineView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -100),
            dottedLineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

    // Method to configure the cell with candidate details
    func configure(firstName: String, lastName: String) {
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension CandidateTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Return the number of interview types
        return interviewTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Return the interview type for the specified row
        return interviewTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Handle selection of interview type
        // You can perform actions based on the selected type
    }
}
