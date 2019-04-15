//
//  AboutMeTableCell.swift
//  Contacts
//
//  Created by SB on 4/10/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class AboutMeTableCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var aboutMeLabel: UILabel!
    @IBOutlet var introductionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.update(nil)
    }
    
    func update(_ contact: Contacts?) {
        aboutMeLabel.attributedText = customBoldedString(from: "About me", nonBoldRange: NSRange(location: 0, length: 0), fontSize: 16)
        
        if let foundContact = contact {
            
            let name = foundContact.firstName + " " + foundContact.lastName
            let range = NSRange(location: foundContact.firstName.count + 1, length: foundContact.lastName.count)
            nameLabel.attributedText = customBoldedString(from: name, nonBoldRange: range, fontSize: 20)
            
            titleLabel.text = foundContact.title
            titleLabel.font = titleLabel.font.withSize(14)
            titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            
            introductionLabel.text = foundContact.introduction
            introductionLabel.font = introductionLabel.font.withSize(14)
            introductionLabel.numberOfLines = 0
            introductionLabel.textColor = UIColor.lightGray
            
        } else {
            nameLabel.text = "Name missing!"
            titleLabel.text = "Title missing!"
            introductionLabel.text = "Introduction text missing!"
        }
    }
    
    func customBoldedString(from string: String, nonBoldRange: NSRange?, fontSize: CGFloat) -> NSAttributedString {
        let attrs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        let nonBoldAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
        ]
        let attrStr = NSMutableAttributedString(string: string, attributes: attrs)
        if let range = nonBoldRange {
            attrStr.setAttributes(nonBoldAttribute, range: range)
        }
        return attrStr
    }
}
