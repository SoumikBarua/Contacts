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
        
        self.update(name: nil, title: nil, intro: nil)
    }
    
    func update(name: String?, title: String?, intro: String?) {
        nameLabel.font = nameLabel.font.withSize(20)
        titleLabel.font = titleLabel.font.withSize(14)
        aboutMeLabel.text = "About Me"
        introductionLabel.font = introductionLabel.font.withSize(14)
        //aboutMeLabel.attributedText
        if let foundName = name, let foundTitle = title, let foundIntro = intro {
            nameLabel.text = foundName
            titleLabel.text = foundTitle
            titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            introductionLabel.text = foundIntro
            introductionLabel.numberOfLines = 0
            introductionLabel.textColor = UIColor.lightGray
        } else {
            nameLabel.text = "Name missing!"
            titleLabel.text = "Title missing!"
            introductionLabel.text = "Introduction text missing!"
        }
    }
}
