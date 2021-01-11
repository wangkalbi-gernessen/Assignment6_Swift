//
//  ToDoItemTableViewCell.swift
//  Todo_app
//
//  Created by Kazunobu Someya on 2021-01-10.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    
    var isComplecatedIndicator: Bool = false
    
    var checkmarkLabel: UILabel = {
        let check = UILabel()
        check.setContentHuggingPriority(.required, for: .horizontal)
        return check
    }()

    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 20)
        title.numberOfLines = 1
        return title
    }()
    
//    lazy var stackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [checkmarkLabel, titleLabel])
//        stack.axis = .horizontal
//        stack.alignment = .fill
//        stack.spacing = 5
//        stack.distribution = .fill
//        return stack
//    }()
    
    let imgLabel = UILabel()
    
    var priorityLevel:priorityLevel = .medium
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
//        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // make stackview for a cell
//    func setupStackView() {
//        contentView.addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//    }
//
    // call this function in TVC
    func update(with info: Information) {
        checkmarkLabel.text = info.isCompletedIndicator ? "✔️" : ""
        titleLabel.text = info.title
        priorityLevel = info.priorityLevel
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        guard isSelected else {return }
//
//        if self.isCompletedIndicator == true {
//            self.isCompletedIndicator = false
//            self.checkmarkLabel.text = " "
//        } else {
//            self.isCompletedIndicator = true
//            self.checkmarkLabel.text = "✔️"
//        }
//    }

}
