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
        getDataFromFirebase()
    }   
    
    func getDataFromFirebase(){
        
        ref.child("todoList").observe(DataEventType.value, with: { (snapshot) in
            if let postDict = snapshot.value as? Dictionary<String, AnyObject> {
                self.allTodos = [TodoTask]()
                for item in postDict {
                    let myTodo = TodoTask(key: item.key, todo: item.value as! NSDictionary)
                    self.allTodos.append(myTodo)
                    self.todoTable.reloadData()
                }
                self.taskCount = Int(postDict.count)
            }
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //self.todoTable.reloadData()
        getDataFromFirebase()
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
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (cell.todoTaskName?.text)!)
    
        if(todo.isCompleted == false){
            attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
            cell.todoTaskSwitchButton.setOn(true, animated: true)
            cell.todoTaskName.attributedText = attributeString
        } else{
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.todoTaskSwitchButton.setOn(false, animated: false)
            cell.todoTaskName.attributedText = attributeString
        }
        
        cell.todoTaskStatus?.text = todo.dueDate
        
        return cell
    }
    
    func strikeThroughText (_ text:String) -> NSAttributedString{
        let strokeEffect: [NSAttributedString.Key : Any] =
            [
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.strikethroughColor: (UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0))
                ]

        let attributeString = NSAttributedString(string: text, attributes: strokeEffect)
        return attributeString
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
