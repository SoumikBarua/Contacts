//
//  Contacts.swift
//  Contacts
//
//  Created by SB on 3/19/19.
//  Copyright © 2019 SB. All rights reserved.
//
import UIKit

class Contacts: NSObject {
    
    var firstName: String
    var lastName: String
    var fileName: String
    var title: String
    var introduction: String
    
    init(firstName: String, lastName: String, fileName: String, title: String, introduction: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.fileName = fileName
        self.title = title
        self.introduction = introduction
        
        super.init()
    }
}
