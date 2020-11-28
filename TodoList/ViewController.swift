//
//  todoTableViewCell.swift
//  TodoList
//
//  Name: Supriya Gadkari
//  Student id: 301140872

import UIKit
import Firebase

class ViewController: UITableViewController {

    var taskCount: Int! = 0
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

}

