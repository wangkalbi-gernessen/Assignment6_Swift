//
//  AddToDoItemTableViewController.swift
//  Todo_app
//
//  Created by Kazunobu Someya on 2021-01-10.
//

import UIKit

protocol AddEditToDoTVCDelegate: class {
    func add(_ toDoItem: Information)
    func edit(_ toDoItem: Information)
}

class AddToDoItemTableViewController: UITableViewController {
    
    let textFieldCell = AddToDoItemTableViewCell()
    
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveToDoItem))
    
    weak var delegate: AddEditToDoTVCDelegate?

    var item: Information?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if item == nil {
            title = "Add ToDo Item"
        } else {
            title = "Edit ToDo Item"
            textFieldCell.textField.text = item?.title
        }
        
        // cancel button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissTVC))
        
        // save button
        navigationItem.rightBarButtonItem = saveButton
        // textfields add target action
        textFieldCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        updateSaveButtonState()
    }
    
    @objc
    func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @objc
    func dismissTVC(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func saveToDoItem(){
        // pass data to ToDoTVC, and update model
        // 1. create a new item
         // 2. pass the item back to ToDoTVC, and append
         // 3. update table view
        let newItem = Information(title: textFieldCell.textField.text!, priorityLevel: .medium, isCompletedIndicator: false)
        if self.item == nil {
        delegate?.add(newItem)
        } else {
        delegate?.edit(newItem)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func updateSaveButtonState(){
        saveButton.isEnabled = checkLetters(textFieldCell.textField)
    }
    
    private func checkLetters(_ textField: UITextField) -> Bool {
        guard let text = textFieldCell.textField.text, text.count >= 1  else {return false}
        return true
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return textFieldCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Item"
    }
}
