//
//  ViewController.swift
//  Today
//
//  Created by Phúc Lý  on 7/24/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray=["Rice","Meat","Vegetable"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Table View Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    // MARK: Table View Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

