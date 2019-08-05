//
//  ItemSearchBarController.swift
//  Today
//
//  Created by Phúc Lý  on 8/5/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import Foundation
import UIKit
import CoreData
extension TodoListViewController : UISearchBarDelegate, UIPickerViewDelegate, UIImagePickerControllerDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //print("searchBarSearchButtonClicked")
        let result:NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        result.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: result, predicate: predicate)
        
        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            self.loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    //    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    //
    //    }
    
}
