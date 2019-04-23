//
//  ContactsDataSource.swift
//  Contacts
//
//  Created by SB on 4/23/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class ContactsDataSource: NSObject, UICollectionViewDataSource, UITableViewDataSource {
    
    var contacts = [Contacts]()
    
    // MARK: - UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCollectionCell", for: indexPath) as! AvatarCollectionCell
        cell.update(with: UIImage(named: "\(contacts[indexPath.item].firstName) \(contacts[indexPath.item].lastName).png"))
        return cell
    }
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutMeTableCell", for: indexPath) as! AboutMeTableCell
        cell.update(contacts[indexPath.row])
        return cell
    }
}
