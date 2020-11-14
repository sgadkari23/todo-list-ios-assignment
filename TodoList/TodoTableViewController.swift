//  todoTableViewCell.swift
//  Assignment:Todo App
//  Name: Supriya Gadkari
//  Student id: 301140872
//


import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet var todoTaskName: UILabel!
    @IBOutlet var todoTaskStatus: UILabel!
    @IBOutlet var todoTaskSwitchButton: UISwitch!
    
    @IBAction func taskIsCompletedSwitchButton(_ sender: UISwitch) {
    
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (todoTaskName?.text)!)
    
        if todoTaskSwitchButton.isOn {
            attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
            todoTaskName.attributedText = attributeString
            todoTaskStatus?.text = "Overdue"
        }else{
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            todoTaskName.attributedText = attributeString
            todoTaskStatus?.text = "Completed"
        }
    }
}

class TodoTableViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet var todoTable: UITableView!
    
    var taskNameArray = ["Shopping List","Grocery List","Travel checklist"]
    var taskStatus = ["Overdue","Overdue","Friday November 14,2020"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTable.delegate = self
        todoTable.dataSource = self
        self.todoTable.rowHeight = 60.0
        self.title = "Todo"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoTableCell", for: indexPath) as! TodoTableViewCell
        cell.todoTaskName?.text = taskNameArray[indexPath.row]
        cell.todoTaskStatus?.text = taskStatus[indexPath.row]
        return cell
    }
}
