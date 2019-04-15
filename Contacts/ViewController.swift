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
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var containerView: UIView!
    var contactsStore: ContactsStore!
    var contacts = [Contacts]()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting up the navigation bar title and adjusting the color of the status bar with view's background color
        navigationBar.topItem?.title = "Contacts"
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        
        // Setting the data source and the delegate of both the collection view and the table view to this view controller
        collectionView.dataSource = self
        tableView.dataSource = self
        collectionView.delegate = self
        tableView.delegate = self
        
        // Setting up the cell sizes for both the collection view and the table view
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: (self.collectionView.frame.width/5 + 1), height: self.collectionView.frame.height*0.75)
            layout.minimumInteritemSpacing = 8
            print("main view width:  \(view.frame.width) and collectionView frame width \(collectionView.frame.width) ")
            layout.sectionInset.left = view.frame.width/2 - layout.itemSize.width/2
            layout.sectionInset.right = layout.sectionInset.left
        }
        tableView.rowHeight = tableView.frame.height //tableView.bounds.maxY - tableView.bounds.minY
        tableView.separatorStyle = .none
        
        // Retrieving the JSON information and updating the collection view and table view
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
            self.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    
    // MARK: - UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCollectionCell", for: indexPath) as! AvatarCollectionCell
        cell.update(with: UIImage(named: "\(contacts[indexPath.item].firstName) \(contacts[indexPath.item].lastName).png"))
        return cell
    }
    
    // MARK: - UICollectionViewDelegate methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
    
    // MARK: - UITableViewDelegate methods
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    }
    
    // MARK: - UIScrollViewDelegate methods
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView is UITableView {
            guard var scrollingToIndexPath = tableView.indexPathForRow(at: CGPoint(x: 0, y: targetContentOffset.pointee.y)) else {
                return
            }
            var scrollingToRect = tableView.rectForRow(at: scrollingToIndexPath)
            let roundingRow = Int(((targetContentOffset.pointee.y - scrollingToRect.origin.y) / scrollingToRect.size.height).rounded())
            scrollingToIndexPath.row += roundingRow
            scrollingToRect = tableView.rectForRow(at: scrollingToIndexPath)
            targetContentOffset.pointee.y = scrollingToRect.origin.y
        }
        
    }

}

