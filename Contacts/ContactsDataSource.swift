//
//  CollectionDataSource.swift
//  Contacts
//
//  Created by SB on 3/19/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class ContactsDataSource: NSObject, UICollectionViewDataSource {
    
    let contacts = [Contacts]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "UICollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
}
