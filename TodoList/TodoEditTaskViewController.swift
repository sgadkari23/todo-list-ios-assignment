//
//  todoTableViewCell.swift
//  Assignment:Todo App
//  Name: Supriya Gadkari
//  Student id: 301140872
//  Date: 11/14/2020
//  Description: Loading todo detail form
import UIKit
import  Firebase

//todo edit form class
class TodoEditTaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var ref: DatabaseReference!
    var todo:TodoTask!
    
    @IBOutlet var todoTaskNameTextField: UITextField!
    @IBOutlet var todoTaskDescriptionTextView: UITextView!
    @IBOutlet var todoTaskHasDueDateSwitchButton: UISwitch!
    @IBOutlet var todoTaskDatePicker: UIDatePicker!
    @IBOutlet var todoTaskIsCompletedSwitchbutton: UISwitch!
    
    
    //view load
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        todo = TodoTask()
        self.todoTaskNameTextField.delegate = self
        self.todoTaskDescriptionTextView.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func changeHasDuedateOnSwitchIsON(_ sender: Any) {
        
        if (sender as AnyObject).isOn {
            todo.hasDueDate = "true"
        }else{
            todo.hasDueDate = "false"
        }
    }
    
    
    @IBAction func changeIsCompletedOnSwitchIsON(_ sender: Any) {
        print("flag : \(String(describing: todo.isCompleted))")
        if (sender as AnyObject).isOn {
            todo.isCompleted = "true"
            
        }else{
            todo.isCompleted = "false"
        }
    }
    
    
    @IBAction func saveTaskOnButtonPressed(_ sender: Any) {
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        todo.dueDate = dateFormatter.string(from: todoTaskDatePicker.date)
        todo.name = todoTaskNameTextField.text!
        todo.taskDescription = todoTaskDescriptionTextView.text!
        
     //   print("todo date selected :",todo.dueDate)
        print("has due date :\(String(describing: todoTaskHasDueDateSwitchButton))")
        
        /*todo.name = "sample1"
        todo.taskDescription = "d1"
        todo.dueDate = "dateFormatter.stringFromDate()"*/
        
        //second section
        let key = ref.child("todoList").childByAutoId().key
        
        let dictionaryTodo = [ "name"        : todo.name,
                               "description" : todo.taskDescription ,
                               "dueDate"     : todo.dueDate,
                               "hasDueDate"  : todo.hasDueDate,
                               "isCompleted" : todo.isCompleted
                               ]
        
        ref.child("todoList").child(key ?? "k1").setValue(dictionaryTodo)
        
    }
    
    
    
}
