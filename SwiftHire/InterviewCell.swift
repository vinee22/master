//
//  InterviewCell.swift
//  SwiftHire
//
//  Created by HS on 15/03/24.
//

import Foundation
import UIKit

class InterviewCell: UITableViewCell {
    // UI elements for the cell
    let typeLabel = UILabel()
    let dateLabel = UILabel()
    let dottedLineView = UIView() // Dotted line view
    
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
        contentView.addSubview(typeLabel)
        contentView.addSubview(dateLabel)

        typeLabel.textColor = AppSettings().primaryColor()
        typeLabel.font = UIFont.systemFont(ofSize: 30)
        dateLabel.textColor = AppSettings().primaryColor()
        dateLabel.font = UIFont.systemFont(ofSize: 15)
  
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            dateLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
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

}
