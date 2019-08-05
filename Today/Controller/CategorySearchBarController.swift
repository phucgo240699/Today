//
//  CategorySearchBarController.swift
//  Today
//
//  Created by Phúc Lý  on 8/5/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import Foundation
import UIKit
import CoreData
extension CategoryViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let result:NSFetchRequest<Category> = Category.fetchRequest()
        result.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        print(searchBar.text!)
        result.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do{
            categoryArray = try context.fetch(result)
        }
        catch {
            print("error")
        }
        
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
