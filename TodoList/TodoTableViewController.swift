//  todoTableViewCell.swift
//  Assignment:	Todo App
//  Name: Supriya Gadkari
//  Student id: 301140872
//  Date: 11/14/2020
//  Description: Listing all todo tasks

import UIKit
import Firebase

//table cell class to manage table row content
class TodoTableViewCell: UITableViewCell {

    //variable declaration
    @IBOutlet var todoTaskName: UILabel!
    @IBOutlet var todoTaskStatus: UILabel!
    @IBOutlet var todoTaskSwitchButton: UISwitch!
    
   
    
   
    //strike task name if completed
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

// display table view
class TodoTableViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ref: DatabaseReference!
    var taskCount: Int? = 0
    
    //variable declaration
    @IBOutlet var todoTable: UITableView!
    var allTodos = [TodoTask]()
    var todo:TodoTask!
    
    @IBOutlet var editTodoTaskButton: UIButton!
    
    //load view
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI table attributes
        todoTable.delegate = self
        todoTable.dataSource = self
        self.todoTable.rowHeight = 60.0
        self.title = "Todo"
        
        
        // get firebase database reference
        ref = Database.database().reference()
        
        ref.child("todoList").observe(DataEventType.value, with: { (snapshot) in
            if let postDict = snapshot.value as? Dictionary<String, AnyObject> {
                for item in postDict {
                    //print("Type \(type(of:item))")
                    print(item)
                    let myTodo = TodoTask(key: item.key, todo: item.value as! NSDictionary)
                    self.allTodos.append(myTodo)
                    self.taskCount = Int(postDict.count)
                    self.todoTable.reloadData()
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is TodoEditTaskViewController
        {
            let vc = segue.destination as? TodoEditTaskViewController
            if segue.identifier == "addTaskDetails" {
                
                vc?.editFlag = false
                
            }else if segue.identifier == "editTaskDetail" {
                
                vc?.editFlag = true
                vc?.todoTaskDetails = todo
            }
            
            ///let vc = segue.destination as? TodoEditTaskViewController
            //vc?.username = "Arthur Dent"
        }
    }
    
    //Tells the data source to return the number of rows in a given section of a table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskCount!
    }
    
    //data source for a cell to insert in a particular location of the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoTableCell", for: indexPath) as! TodoTableViewCell
        todo = allTodos[indexPath.row]
        cell.todoTaskName?.text = todo.name
        cell.todoTaskStatus?.text = todo.dueDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subMenuVC = storyboard?.instantiateViewController(identifier: "view") as? TodoEditTaskViewController
        let todo = allTodos[indexPath.row]
        subMenuVC?.todoTaskDetails = todo
        subMenuVC?.editFlag = true
        self.navigationController?.pushViewController(subMenuVC!, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

