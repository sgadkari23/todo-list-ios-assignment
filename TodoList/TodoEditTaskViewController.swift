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
class TodoEditTaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate  {
    
    var ref: DatabaseReference!
    var todoTaskDetails:TodoTask!
    var editFlag:Bool!
    //var todo:TodoTask!
    
    @IBOutlet var todoTaskNameTextField: UITextField!
    @IBOutlet var todoTaskDescriptionTextView: UITextView!
    @IBOutlet var todoTaskHasDueDateSwitchButton: UISwitch!
    @IBOutlet var todoTaskDatePicker: UIDatePicker!
    @IBOutlet var todoTaskIsCompletedSwitchbutton: UISwitch!
    
    @IBOutlet var enableEditButton: UIButton!
    
    //view load
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        if !editFlag {
           todoTaskDetails = TodoTask()
           enableEditButton.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        }
        
        todoTaskNameTextField.text = todoTaskDetails.name
        todoTaskDescriptionTextView.text = todoTaskDetails.taskDescription
        
        if todoTaskNameTextField.text == ""{
            todoTaskHasDueDateSwitchButton.isHidden = true
            todoTaskIsCompletedSwitchbutton.isHidden = true
            enableEditButton.isHidden = true
        }
        //print(todoTaskDetails.isCompleted)
        
        if(todoTaskDetails.isCompleted == false){
            todoTaskIsCompletedSwitchbutton.setOn(true, animated: true)
        }else{
            todoTaskIsCompletedSwitchbutton.setOn(false, animated: true)
            //todoTaskIsCompletedSwitchbutton.onTintColor = .clear
        }
        
        if(todoTaskDetails.hasDueDate == true){
            todoTaskHasDueDateSwitchButton.setOn(true, animated: true)
        }else{
            todoTaskHasDueDateSwitchButton.setOn(false, animated: true)
            todoTaskDatePicker.isEnabled = false
           // todoTaskHasDueDateSwitchButton.onTintColor = .clear
        }
       // let date = formater.date(from: todoTaskDatePicker.date ) ?? Date()
        let formater = DateFormatter()
        formater.dateFormat = "MM/dd/yyyy"
        let date = formater.date(from: todoTaskDetails.dueDate) ?? Date()
        todoTaskDatePicker.setDate(date, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        //safeGuard()
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != ""{
            todoTaskHasDueDateSwitchButton.isHidden = false
            todoTaskIsCompletedSwitchbutton.isHidden = false
            enableEditButton.isHidden = false
        }
    }

    
    @IBAction func todoTaskDeleteOnButtonPressed(_ sender: UIButton) {
        
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
        
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                //self.deleteArtist(id: "MNKrDgplRGDVVqBxxEg")
            self.ref.child("todoList").child(self.todoTaskDetails.uniqueId).removeValue()
            
            self.navigationController?.popToRootViewController(animated: true)
        })

        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                    print("Cancel button tapped")
                }
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)

       // print(dialogMessage )
    }

    
    @IBAction func editTodoTaskOnButtonPressed(_ sender: Any) {
      /*  if !editFlag {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            todoTaskDetails.dueDate = dateFormatter.string(from: todoTaskDatePicker.date)
            todoTaskDetails.name = todoTaskNameTextField.text!
            todoTaskDetails.taskDescription = todoTaskDescriptionTextView.text!
            
            let key = todoTaskDetails.uniqueId
            
            let dictionaryTodo = [ "name"        : todoTaskDetails.name,
                                   "description" : todoTaskDetails.taskDescription ,
                                   "dueDate"     : todoTaskDetails.dueDate,
                                   "hasDueDate"  : todoTaskDetails.hasDueDate,
                                   "isCompleted" : todoTaskDetails.isCompleted
            ] as [String : Any]
            
            ref.child("todoList").child(key).updateChildValues(dictionaryTodo)
            navigationController?.popToRootViewController(animated: true)
        } */
        
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to discard the changes?", preferredStyle: .alert)
        
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                //self.deleteArtist(id: "MNKrDgplRGDVVqBxxEg")
            
            self.navigationController?.popToRootViewController(animated: true)
        })

        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        }
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    func customInit(todo:TodoTask) {
        self.todoTaskDetails = todo
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
            todoTaskDetails.hasDueDate = true
            todoTaskDatePicker.isEnabled = true
        }else{
            todoTaskDetails.hasDueDate = false
            todoTaskDatePicker.isEnabled = false
        }
    }
    
    
    @IBAction func changeIsCompletedOnSwitchIsON(_ sender: Any) {
       // print("flag : \(String(describing: todoTaskDetails.isCompleted))")
        if (sender as AnyObject).isOn {
            todoTaskDetails.isCompleted = false
            
        }else{
            todoTaskDetails.isCompleted = true
        }
    }
    
    
    @IBAction func saveTaskOnButtonPressed(_ sender: Any) {
        if !editFlag {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            todoTaskDetails.dueDate = dateFormatter.string(from: todoTaskDatePicker.date)
            todoTaskDetails.name = todoTaskNameTextField.text!
            todoTaskDetails.taskDescription = todoTaskDescriptionTextView.text!
            
         //   print("todo date selected :",todo.dueDate)
            print("has due date :\(String(describing: todoTaskHasDueDateSwitchButton))")
            
            /*todo.name = "sample1"
            todo.taskDescription = "d1"
            todo.dueDate = "dateFormatter.stringFromDate()"*/
            
            //second section
            let key = ref.child("todoList").childByAutoId().key
            
            let dictionaryTodo = [ "name"        : todoTaskDetails.name,
                                   "description" : todoTaskDetails.taskDescription ,
                                   "dueDate"     : todoTaskDetails.dueDate,
                                   "hasDueDate"  : todoTaskDetails.hasDueDate,
                                   "isCompleted" : todoTaskDetails.isCompleted
            ] as [String : Any]
            
            ref.child("todoList").child(key ?? "k1").setValue(dictionaryTodo)
            navigationController?.popToRootViewController(animated: true)
        }else{
            let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to discard the changes?", preferredStyle: .alert)
            
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                self.todoTaskDetails.dueDate = dateFormatter.string(from: self.todoTaskDatePicker.date)
                self.todoTaskDetails.name = self.todoTaskNameTextField.text!
                self.todoTaskDetails.taskDescription = self.todoTaskDescriptionTextView.text!
                
                let key = self.todoTaskDetails.uniqueId
                
                let dictionaryTodo = [ "name"        : self.todoTaskDetails.name,
                                       "description" : self.todoTaskDetails.taskDescription ,
                                       "dueDate"     : self.todoTaskDetails.dueDate,
                                       "hasDueDate"  : self.todoTaskDetails.hasDueDate,
                                       "isCompleted" : self.todoTaskDetails.isCompleted
                ] as [String : Any]
                
                self.ref.child("todoList").child(key).updateChildValues(dictionaryTodo)
                
                self.navigationController?.popToRootViewController(animated: true)
            })

            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                
            }
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            self.present(dialogMessage, animated: true, completion: nil)
            
        }
        
    }
    
    
}
