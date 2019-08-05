//
//  ViewController.swift
//  Today
//
//  Created by Phúc Lý  on 7/24/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController  {
    var selectedCategory:Category?{
        didSet{
            loadItems()
        }
    }
    var itemArray=[Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title? = selectedCategory!.name ?? ""
        
    }
    
    // MARK: Table View Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //        let item=itemArray[indexPath.row]
        //
        //        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    // MARK: Table View Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Button Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "Do you want to add it?", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem=Item(context: self.context)
            newItem.title=textField.text ?? ""
            newItem.done=false
            newItem.parentCategory=self.selectedCategory
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Typing name of new item"
            textField=alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        
        do{
            try context.save()
        } catch{ }
        self.tableView.reloadData()
    }
    
    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest(), predicate:NSPredicate? = nil){
        let categoryPredicate=NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let additionalPredicate = predicate{
            request.predicate=NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        }
        else{
            request.predicate=categoryPredicate
        }
        
        do{
            itemArray = try context.fetch(request)
        }
        catch {
            print("Error fetching request: \(error)")
        }
    }
}
