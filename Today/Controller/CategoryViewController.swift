//
//  CategoryViewController.swift
//  Today
//
//  Created by Phúc Lý  on 8/5/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import UIKit
import RealmSwift
class CategoryViewController: UITableViewController {
    
    var realm=try! Realm()
    
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        loadCategorys()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text=categoryArray?[indexPath.row].name ?? "No categories added yet"
        
        
        return cell
    }
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
            self.saveCategorys(category: newCategory)
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
    
}
