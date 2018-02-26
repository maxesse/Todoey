//
//  ViewController.swift
//  Todoey
//
//  Created by Max Sanna on 22/02/2018.
//  Copyright © 2018 Max Sanna. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeTableViewController {

    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
    let defaults = UserDefaults.standard
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        cell.backgroundColor = UIColor(hexString: todoItems?[indexPath.row].colour ?? "#FFFFFF")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }


        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button on our UIAlert
            
        if let currentCategory = self.selectedCategory {
            do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    currentCategory.items.append(newItem)
                }
            } catch {
                print("Error saving new items, \(error)")
            }
        }
        self.tableView.reloadData()

        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Model Manipulation Methods

    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        // Update our data model
        if let itemForDeletion = todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(itemForDeletion)
                }
            } catch {
                print("Error deleting the item: \(error)")
            }
            
        }
    }
    

}

// MARK: Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}

