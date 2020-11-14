//  todoTableViewCell.swift
//  Assignment:Todo App
//  Name: Supriya Gadkari
//  Student id: 301140872
//


import UIKit

class TodoTableViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet var todoTable: UITableView!
    
    var taskNameArray = ["Shopping List","Grocery List","Travel checklist"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTable.delegate = self
        todoTable.dataSource = self
        self.todoTable.rowHeight = 60.0
    }
    
    
    @IBAction func taskIsCompletedSwitchButton(_ sender: UISwitch) {
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Your Text")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
    //todoTaskName.attributedText = attributeString
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskNameArray.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // #warning Incomplete implementation, return the number of rows
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoTableCell", for: indexPath) as! TodoTableViewCell
        cell.todoTaskName?.text = taskNameArray[indexPath.row]
        cell.todoTaskStatus?.text = "Completed"
        //cell.accessoryView = UISwitch()
        //cell.todoTaskEdit.image = UIImage(named: "imgCat")
        
        if cell.todoTaskSwitchButton.isOn {
            //cell.todoTaskName.text = attributeString
            print("ON")
            //let attrString = NSAttributedString(string: "Label Text", attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle])
            //label.attributedText = attrString
            //let attrString = NSAttributedString(string: "Label Text", attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
            
            cell.todoTaskStatus.text = "Completed"
            //stateSwitch.setOn(true, animated:true)
        }
        else{
            print("OFF")
        }
        return cell

    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
