//
//  CategoryViewController.swift
//  Today
//
//  Created by Phúc Lý  on 8/5/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework
class CategoryViewController: SwipeTableViewController {
    
    var realm=try! Realm()
    
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70.0
        loadCategorys()
    }
    
    // MARK: - Table view datasource method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text=categoryArray?[indexPath.row].name ?? "No categories added yet"
        cell.backgroundColor=UIColor(hexString: (categoryArray?[indexPath.row].color) ?? "FFFFFF")
        return cell
    }
    
    // MARK: - Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC=segue.destination as! TodoListViewController
        if let indexPath=tableView.indexPathForSelectedRow{ destinationVC.selectedCategory=categoryArray?[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "Do you want to add it?", preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory=Category()
            newCategory.name=textField.text ?? ""
            newCategory.color=UIColor.randomFlat().hexValue()
            
            if newCategory.name.isEmpty == false{
                self.saveCategorys(category: newCategory)
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Typing name of new Category"
            textField=alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    func saveCategorys(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        } catch { }
        self.tableView.reloadData()
    }
    
    func loadCategorys(){
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    override func updateModel(at index: IndexPath) {
        if let categoryForDeletion = self.categoryArray?[index.row]{
            do{
                try self.realm.write {
                    self.realm.delete (categoryForDeletion)
                }
            } catch { }
        }
    }
}
