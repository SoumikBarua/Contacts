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
    @IBOutlet var tablewView: UITableView!
    let contactsDataSource = ContactsDataSource()
    var contactsStore: ContactsStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting the data source of this collection view to custom ContactsDataSource
        collectionView.dataSource = contactsDataSource
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 150, height: self.collectionView.frame.height)
        }
        
        // Retrieving the JSON information and passing it to the data source
        contactsStore.fetchJSON {
            (contactsResult) -> Void in
            
            switch contactsResult {
            case let .success(contacts):
                print("Successfully found \(contacts.count) contacts")
                self.contactsDataSource.contacts = contacts
            case let .failure(error):
                print("Error retrieving contacts: \(error)")
                self.contactsDataSource.contacts.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }

}

