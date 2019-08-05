//
//  CategoryViewController.swift
//  Today
//
//  Created by Phúc Lý  on 8/5/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {
    
    var categoryArray=[Category]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategorys()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text=categoryArray[indexPath.row].name
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC=segue.destination as! TodoListViewController
        if let indexPath=tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory=categoryArray[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "Do you want to add it?", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory=Category(context: self.context)
            newCategory.name=textField.text ?? ""
            self.categoryArray.append(newCategory)
            self.saveCategorys()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Typing name of new Category"
            textField=alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategorys(){
        do{
            try context.save()
        } catch { }
        self.tableView.reloadData()
    }
    
    func loadCategorys(){
        let request:NSFetchRequest<Category> = Category.fetchRequest()
        //print(request)
        do{
            categoryArray = try context.fetch(request)
        }
        catch {
            print("Error fetching request: \(error)")
        }
        tableView.reloadData()
    }
    
}
