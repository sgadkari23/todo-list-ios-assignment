//
//  File name: ViewController.swift
//  Assignment:Todo App
//  Name: Supriya Gadkari
//  Student id: 301140872
//  Date: 11/14/2020
//  Description: ViewController
//
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

