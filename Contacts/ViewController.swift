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
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var containerView: UIView!
    var contactsStore: ContactsStore!
    let contactsDataSource = ContactsDataSource()
    var onTapSelectItem = true
    var tableViewScroll = false
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting up the navigation bar title and adjusting the color of the status bar with view's background color
        navigationBar.topItem?.title = "Contacts"
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        
        // Setting the data source and the delegate of both the collection view and the table view to this view controller
        collectionView.dataSource = contactsDataSource
        tableView.dataSource = contactsDataSource
        collectionView.delegate = self
        tableView.delegate = self
        
        // Setting up the view properties for both the collection view and the table view
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: (self.collectionView.frame.width/5 + 1), height: self.collectionView.frame.height*0.75)
            layout.sectionInset.left = view.frame.width/2 - layout.itemSize.width/2
            layout.sectionInset.right = layout.sectionInset.left
        }
        collectionView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = tableView.frame.height //tableView.bounds.maxY - tableView.bounds.minY
        tableView.separatorStyle = .none
        
        updateDataSource()
    }
    
    private func updateDataSource() {
        // Retrieving the JSON information and updating the collection view and table view
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
            self.tableView.reloadData()
            self.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}


// MARK: - UICollectionViewDelegate methods

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTapSelectItem = true
        tableViewScroll = false
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UITableViewDelegate methods

extension ViewController: UITableViewDelegate {
    // No table view delegate methods needed
}

// MARK: - UIScrollViewDelegate methods

extension ViewController {
    // Both UICollectionViewDelegate and UITableViewDelegate inherit from UIScrollViewDelegate
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView is UITableView {
            // Row snapping for the table view
            
            // Determine the closest row number by comparing the targetContentOffset to the table view's row height
            let approximateRowNumber = Int(((targetContentOffset.pointee.y) / (tableView.rowHeight)).rounded())
            // Find the approximate row's frame
            let scrollingToRect = tableView.rectForRow(at: IndexPath(row: approximateRowNumber, section: 0))
            // Set the rounded offset
            targetContentOffset.pointee.y = scrollingToRect.origin.y
            
            collectionView.selectItem(at: IndexPath(item: approximateRowNumber, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
        if scrollView is UICollectionView {
            // Item snapping for the collection view
            
            // Determine the closest item number by comparing the targetContentOffset to the current layout's item size and line spacing
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let approximateItemNumber = Int((targetContentOffset.pointee.x / (layout.itemSize.width + layout.minimumLineSpacing)).rounded())
            // Find the approximate item's frame
            let scrollingToRect = collectionView.layoutAttributesForItem(at: IndexPath(item: approximateItemNumber, section: 0))?.frame
            // Set the rounded offset
            targetContentOffset.pointee.x = (scrollingToRect?.origin.x)! - layout.sectionInset.left
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView {
            // To highlight the collection view cells during a scroll (ignore if an individual cell is tapped)
            if !onTapSelectItem {
                // Find layout information to compare to current offset
                let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                let approximateItemNumber = Int((scrollView.contentOffset.x / (layout.itemSize.width + layout.minimumLineSpacing)).rounded())
                // Set the approximate item to be highlighted
                collectionView.selectItem(at: IndexPath(item: approximateItemNumber, section: 0), animated: false, scrollPosition: [])
                
                // Set this table view offset only when the collection view is scrolled
                // (allowing this during a table view scroll will add extra unwanted offset)
                if !tableViewScroll {
                    tableView.contentOffset.y = (scrollView.contentOffset.x) * (tableView.rowHeight) / (layout.itemSize.width + layout.minimumLineSpacing)
                }
            }
        } else if scrollView is UITableView {
            if tableViewScroll {
                let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                collectionView.contentOffset.x = (scrollView.contentOffset.y) * (layout.itemSize.width + layout.minimumLineSpacing) / (tableView.rowHeight)
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView {
            // Drag (instead of item tap) occurred was in collection view
            onTapSelectItem = false
            tableViewScroll = false
        } else {
            // Drag occurred in table view
            onTapSelectItem = false
            tableViewScroll = true
        }
    }
}

