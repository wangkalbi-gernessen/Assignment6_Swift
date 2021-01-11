//
//  ToDoItemTableViewCell.swift
//  Todo_app
//
//  Created by Kazunobu Someya on 2021-01-10.
//

import UIKit

class ToDoItemTableViewController: UITableViewController, AddEditToDoTVCDelegate {
    let cellId = "cell"
    
    // Data Source
    var information: [Information] = [
        Information(title:"Study Swift", priorityLevel: priorityLevel.high, isCompletedIndicator: true),
        Information(title:"Study React.js", priorityLevel: priorityLevel.high, isCompletedIndicator: false),
        Information(title:"Go to job", priorityLevel: priorityLevel.high, isCompletedIndicator: false),
        Information(title:"Make resume", priorityLevel: priorityLevel.medium, isCompletedIndicator: false),
        Information(title:"Acquire English words", priorityLevel: priorityLevel.medium, isCompletedIndicator: false),
        Information(title:"Listen to IELTS", priorityLevel: priorityLevel.low, isCompletedIndicator: false),
        Information(title:"Eat lunch", priorityLevel: priorityLevel.low, isCompletedIndicator: false),
    ]
    
    var sections: [String] = ["High Priority", "Medium Priority", "Low Priority"]
    var highPriorities:[Information] = []
    var mediumPriorities:[Information] = []
    var lowPriorities:[Information] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "ToDo Items"
    
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDoItem))
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: cellId)
       
        // calculate height from estimated height automatically
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.allowsMultipleSelectionDuringEditing = true
        addInfoToPriority()
    }

    @objc
    func addToDoItem(){
        // present modally (AddEditToDoItemTVC)
        let addEditTVC = AddToDoItemTableViewController(style: .insetGrouped)
        addEditTVC.delegate = self
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC,animated: true,completion: nil)
    }
    
    func add(_ info: Information) {
        information.append(info)
        switch info.priorityLevel {
        case .high:
            highPriorities.append(info)
            tableView.insertRows(at: [IndexPath(row: highPriorities.count - 1, section: 0)], with: .automatic)
        case .medium:
            mediumPriorities.append(info)
            tableView.insertRows(at: [IndexPath(row: mediumPriorities.count - 1, section: 1)], with: .automatic)
        case .low:
            lowPriorities.append(info)
            tableView.insertRows(at: [IndexPath(row: lowPriorities.count - 1, section: 2)], with: .automatic)
        }
    }
    
    func updateInformation(){
            information = [Information]()
            information = highPriorities + mediumPriorities + lowPriorities
        }
    
    func edit(_ info: Information) {
        if let indexPath = tableView.indexPathForSelectedRow {
            switch indexPath.section {
            case 0:
                if let row = tableView.indexPathForSelectedRow?.row {
                    // update model
                    highPriorities.remove(at: row)
                    highPriorities.insert(info, at: row)
                    // update view
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            case 1:
                if let row = tableView.indexPathForSelectedRow?.row {
                    mediumPriorities.remove(at: row)
                    mediumPriorities.insert(info, at: row)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            case 2:
                if let row = tableView.indexPathForSelectedRow?.row {
                    lowPriorities.remove(at: row)
                    lowPriorities.insert(info, at: row)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            default:
            print("Editing error")
            }
        }
    }
    
    func addInfoToPriority(){
        // Create different array depends on priorities
        for item in information {
            if item.priorityLevel == .high {
                highPriorities.append(item)
            } else if item.priorityLevel == .medium {
                mediumPriorities.append(item)
            } else if item.priorityLevel == .low {
                lowPriorities.append(item)
            } else {
                print("error: no priority defined")
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    // ROW NUMBER PER SECTION
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Count Row items depends on priority level
        switch section {
        case  0:
            let highPriorityItems = information.filter{ $0.priorityLevel == .high}
            return highPriorityItems.count
        case  1:
            let mediumPriorityItems = information.filter{ $0.priorityLevel == .medium}
            return mediumPriorityItems.count
        case  2:
            let lowPriorityItems = information.filter{ $0.priorityLevel == .low}
            return lowPriorityItems.count
        default:
            return 0
        }
    }

    
    // set value on each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId , for: indexPath) as! TodoItemTableViewCell
        cell.showsReorderControl = true
   
        switch indexPath.section {
        case 0:
            let info = highPriorities[indexPath.row]
            cell.update(with: info)
            cell.textLabel?.text = info.title
            cell.accessoryType = .detailDisclosureButton
            cell.tintColor = .blue
            return cell
        case 1:
            let info = mediumPriorities[indexPath.row]
            cell.update(with: info)
            cell.textLabel?.text = info.title
            cell.accessoryType = .detailDisclosureButton
            cell.tintColor = .blue
            return cell
        case 2:
            let info = lowPriorities[indexPath.row]
            cell.update(with: info)
            cell.textLabel?.text = info.title
            cell.accessoryType = .detailDisclosureButton
            cell.tintColor = .blue
            return cell
        default:
            cell.titleLabel.text = "error"
            return cell
        }
    }
    
    // reorder cell
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        switch sourceIndexPath.section {
        case 0:
            var removeItem = highPriorities.remove(at: sourceIndexPath.row)
            switch destinationIndexPath.section {
            case 0:
                highPriorities.insert(removeItem, at: destinationIndexPath.row)
            case 1:
                removeItem.priorityLevel = .medium
                mediumPriorities.insert(removeItem, at: destinationIndexPath.row)
            case 2:
                removeItem.priorityLevel = .low
                lowPriorities.insert(removeItem, at: destinationIndexPath.row)
            default:
                print("")
            }
        case 1:
            var removeItem = mediumPriorities.remove(at: sourceIndexPath.row)
            switch destinationIndexPath.section {
            case 0:
                removeItem.priorityLevel = .high
                highPriorities.insert(removeItem, at: destinationIndexPath.row)
            case 1:
                mediumPriorities.insert(removeItem, at: destinationIndexPath.row)
            case 2:
                removeItem.priorityLevel = .low
                lowPriorities.insert(removeItem, at: destinationIndexPath.row)
            default:
                print("")
            }
        case 2:
            var removeItem = lowPriorities.remove(at: sourceIndexPath.row)
            switch destinationIndexPath.section {
            case 0:
                removeItem.priorityLevel = .high
                highPriorities.insert(removeItem, at: destinationIndexPath.row)

            case 1:
                removeItem.priorityLevel = .medium
                mediumPriorities.insert(removeItem, at: destinationIndexPath.row)
            case 2:
                lowPriorities.insert(removeItem, at: destinationIndexPath.row)
            default:
                print("")
            }

        default:
            print("")
        }
        // update model
        information = []
        information = highPriorities + mediumPriorities  + lowPriorities

    }
    
    // select specific cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addEditTVC = AddToDoItemTableViewController(style: .insetGrouped)
        addEditTVC.delegate = self
        switch indexPath.section {
        case 0:
            addEditTVC.item = highPriorities[indexPath.row]           // copy
    
        case 1:
            addEditTVC.item = mediumPriorities[indexPath.row]
        case 2:
            addEditTVC.item = lowPriorities[indexPath.row]
        default:
            print("")
        }
        
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC,animated: true,completion: nil)
        
        switch indexPath.section {
        case 0:
            var item = highPriorities[indexPath.row]
//            print(item)
            if item.isCompletedIndicator == false {
                item.isCompletedIndicator = true
//                print(item)
                // update view
                
            } else if item.isCompletedIndicator == true {
                item.isCompletedIndicator = false
            }
        case 1:
            var item = mediumPriorities[indexPath.row]
            if item.isCompletedIndicator == false {
                item.isCompletedIndicator = true
            } else if item.isCompletedIndicator == true {
                item.isCompletedIndicator = false
            }
        case 2:
            var item = lowPriorities[indexPath.row]
            if item.isCompletedIndicator == false {
                item.isCompletedIndicator = true
            } else if item.isCompletedIndicator == true {
                item.isCompletedIndicator = false
            }
        default:
            print("")
        }
    }
    
    // delete specific cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete {
            switch indexPath.section {
            case 0:
                highPriorities.remove(at: indexPath.row)
                print(highPriorities)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            case 1:
                mediumPriorities.remove(at: indexPath.row)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            case 2:
                lowPriorities.remove(at: indexPath.row)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            default:
                print("error")
            }
            updateInformation()
            tableView.reloadData()
        }
    }
    
    // set value on section title
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
}
