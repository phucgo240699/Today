//
//  ViewController.swift
//  Today
//
//  Created by Phúc Lý  on 7/24/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import UIKit
import RealmSwift
class TodoListViewController: SwipeTableViewController  {
    var realm=try! Realm()
    
    var selectedCategory:Category?{
        didSet{
            loadItems()
        }
    }
    var itemArray:Results<Item>?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title? = selectedCategory!.name
        tableView.rowHeight = 70.0
        loadItems()
        
    }
    
    // MARK: Table View Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=super.tableView(tableView, cellForRowAt: indexPath)
        if let items = itemArray?[indexPath.row]{
            cell.textLabel?.text = items.title
            cell.accessoryType = items.done == true ? .checkmark : .none
        } else{
            cell.textLabel?.text = "No items added yet"
        }
        
        return cell
    }
    
    // MARK: Table View Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item=itemArray?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status \(error)")
            }
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: Button Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "Do you want to add it?", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem=Item()
                        newItem.title=textField.text ?? ""
                        newItem.dateCreated=Date()
                        if newItem.title.isEmpty == false{
                        currentCategory.items.append(newItem)
                        }
                    }
                } catch{ }
            }
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Typing name of new item"
            textField=alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(item:Item){
        
        do{
            try realm.write {
                realm.add(item)
            }
        } catch{ }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        itemArray=selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    override func updateModel(at index: IndexPath) {
        if let itemForDeletion = itemArray?[index.row]{
            do{
                try self.realm.write {
                    self.realm.delete (itemForDeletion)
                }
            } catch { }
            
        }
    }
}
