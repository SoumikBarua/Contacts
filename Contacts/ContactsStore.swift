//
//  ContactsStore.swift
//  Contacts
//
//  Created by SB on 4/8/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

enum ContactResult {
    case success([Contacts])
    case failure(Error)
}

class ContactsStore {
    
    var allContacts = [Contacts]()
    
    func fetchJSON(completion: @escaping (ContactResult) -> Void) {
        // Go to the URL for JSON data
        let urlString = "https://raw.githubusercontent.com/outlook/jobs/master/instructions/ios/contacts.json"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
            
            if let jsonData = data {
                // Parsing done here
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    //print(jsonObject)
                    
                    guard
                        let jsonDictionary = jsonObject as? [[String : Any]] else {
                            print("Issues with converting jsonObject as? [String:Any]")
                            return
                    }
                    
                    for contactJSON in jsonDictionary {
                        if let contact = ContactsStore.contact(fromJSON: contactJSON) {
                            self.allContacts.append(contact)
                        }
                    }
                    
                    OperationQueue.main.addOperation {
                        completion(.success(self.allContacts))
                    }
                }
                catch let error {
                    print("Received this error: \(error)")
                }
            } else {
                return
            }
        }.resume()
    }
    
    private static func contact(fromJSON json: [String : Any]) -> Contacts? {
        guard
            let firstName = json["first_name"] as? String,
            let lastName = json["last_name"] as? String,
            let fileName = json["avatar_filename"] as? String,
            let title = json["title"] as? String,
            let introduction = json["introduction"] as? String else {
                return nil
        }
        //print("Came to creating contacts")
        return Contacts(firstName: firstName, lastName: lastName, fileName: fileName, title: title, introduction: introduction)
    }
    
}
