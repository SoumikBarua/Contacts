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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = collectionDataSource
    }

}

