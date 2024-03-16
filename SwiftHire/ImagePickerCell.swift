//
//  ImagePickerCell.swift
//  SwiftHire
//
//  Created by HS on 15/03/24.
//

import Foundation
import UIKit

protocol ImagePickerCellDelegate: AnyObject {
    func didSelectImage(image: UIImage?)
}

class ImagePickerCell: UITableViewCell {
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: ImagePickerCellDelegate?
    
    // Action method when the image is selected
    @IBAction func imageSelected(_ sender: Any) {
        // Call the delegate method when an image is selected
        delegate?.didSelectImage(image: customImageView.image)
    }
    
    // Custom method to configure the cell with data
    func configure(image: UIImage?, title: String) {
        customImageView.image = image
        titleLabel.text = title
    }
}

