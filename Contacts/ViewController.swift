//
//  ViewController.swift
//  Contacts
//
//  Created by SB on 3/19/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    let collectionDataSource = ContactsDataSource()
    let contactsStore = ContactsStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = collectionDataSource
        contactsStore.fetchJSON {
            (contactsResult) -> Void in
            
            switch contactsResult {
            case let .success(contacts):
                print("Successfully found \(contacts.count) contacts")
            case let .failure(error):
                print("Error retrieving contacts: \(error)")
            }
        }
    }

}

