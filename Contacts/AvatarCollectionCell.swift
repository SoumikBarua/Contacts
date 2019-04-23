//
//  AvatarCollectionCell.swift
//  Contacts
//
//  Created by SB on 4/9/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class AvatarCollectionCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var borderView: UIView!
    
    // Check to see if a cell was selected
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                // Selected cell should have a circuler border around the avatar
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                // Change layer properties that you don't want to animate
                borderView.layer.cornerRadius = self.borderView.frame.width/2
                borderView.layer.borderWidth = 5
                CATransaction.commit()
                borderView.layer.borderColor = UIColor(red: 203/255, green: 224/255, blue: 242/255, alpha: 1.0).cgColor
            } else {
                // Get rid of the border if not selected
                borderView.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }

    
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            activityIndicator.hidesWhenStopped = true
            activityIndicator.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            activityIndicator.startAnimating()
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        update(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }

}
