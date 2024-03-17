//
//  Checkbox.swift
//  SwiftHire
//
//  Created by HS on 17/03/24.
//

import Foundation
import UIKit

class Checkbox: UIButton {
    // Images for checked and unchecked states
    let checkedImage = UIImage(named: "HomeIcon")
    let uncheckedImage = UIImage(named: "BackIcon")
    
    // Boolean property to track the current state of the checkbox
    var isChecked: Bool = false {
        didSet {
            // Toggle between the checked and unchecked images based on the isChecked value
            imageView?.image = isChecked ? checkedImage : uncheckedImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Initially set the checkbox to unchecked state
        isChecked = false
        
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        // Configure the image view
        imageView?.contentMode = .scaleAspectFit
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView!)
        imageView?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initially set the checkbox to unchecked state
        isChecked = false
        
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        // Configure the image view
        imageView?.contentMode = .scaleAspectFit
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView!)
        imageView?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // Function to handle checkbox tap
    @objc func buttonClicked(sender: UIButton) {
        isChecked = !isChecked // Toggle isChecked value
    }
}
