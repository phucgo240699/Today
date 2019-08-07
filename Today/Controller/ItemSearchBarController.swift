//
//  ItemSearchBarController.swift
//  Today
//
//  Created by Phúc Lý  on 8/5/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import Foundation
import UIKit
extension TodoListViewController : UISearchBarDelegate, UIPickerViewDelegate, UIImagePickerControllerDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        itemArray=realm.objects(Item.self)
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text ?? "").sorted(byKeyPath: "dateCreated", ascending: true)
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
    
}
