//
//  CategorySearchBarController.swift
//  Today
//
//  Created by Phúc Lý  on 8/5/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import Foundation
import UIKit
extension CategoryViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        categoryArray=realm.objects(Category.self)
        categoryArray=categoryArray?.filter("name CONTAINS[cd] %@", searchBar.text!)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            self.loadCategorys()
            DispatchQueue.main.async { searchBar.resignFirstResponder()
            }
        }
    }
}
