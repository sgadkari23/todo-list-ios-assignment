//
//  File name: todoTask.swift
//  Assignment:Todo App
//  Name: Supriya Gadkari
//  Student id: 301140872
//  Date: 11/14/2020
//  Description: Todo Model
//

import Foundation
// todo method
class TodoTask: NSObject {
    var name :String
    var taskDescription: String
    var hasDueDate:Bool
    var dueDate: String
    var uniqueId:String
    var isCompleted: Bool
    
    
    init( name: String, taskDescription: String, hasDueDate: Bool, dueDate: String, uniqueId: String, isCompleted: Bool) {
            self.name = name
            self.taskDescription = taskDescription
            self.hasDueDate = hasDueDate
            self.dueDate = dueDate
            self.uniqueId = uniqueId
            self.isCompleted = isCompleted
    }

    init(key: String, todo: NSDictionary) {
       
        self.name = todo["name"] as! String
        self.taskDescription = todo["description"] as! String
        self.hasDueDate = todo["hasDueDate"] as! Bool
        self.dueDate = todo["dueDate"] as! String
        self.uniqueId = key
        self.isCompleted = todo["isCompleted"] as! Bool
    }

    convenience override init() {
        self.init(name: "", taskDescription: "", hasDueDate: false , dueDate: "", uniqueId: "", isCompleted: false)
    }
}
