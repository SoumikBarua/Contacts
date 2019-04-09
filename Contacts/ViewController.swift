//
//  ViewController.swift
//  Contacts
//
//  Created by SB on 3/19/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UITableViewDataSource, UICollectionViewDelegate, UITableViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    //let contactsDataSource = ContactsDataSource()
    var contactsStore: ContactsStore!
    var contacts = [Contacts]()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting the data source and the delegate of both the collection view and the table view to this view controller
        collectionView.dataSource = self
        tableView.dataSource = self
        collectionView.delegate = self
        tableView.delegate = self
        
        // Setting up the cell sizes for both the collection view and the table view
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 150, height: self.collectionView.frame.height)
        }
        tableView.rowHeight = tableView.frame.height
        
        // Retrieving the JSON information and passing it to the data source
        contactsStore.fetchJSON {
            (contactsResult) -> Void in
            
            switch contactsResult {
            case let .success(contacts):
                print("Successfully found \(contacts.count) contacts")
                //self.contactsDataSource.contacts = contacts
                self.contacts = contacts
            case let .failure(error):
                print("Error retrieving contacts: \(error)")
                //self.contactsDataSource.contacts.removeAll()
                self.contacts.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

}

