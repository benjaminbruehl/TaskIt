//
//  ViewController.swift
//  TaskIt
//
//  Created by Benjamin Brühl on 17.11.14.
//  Copyright (c) 2014 self.edu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
//    var taskArray:[Dictionary<String,String>] = [] //an array of dictionaries that each hold key - value pairs of type string. So the key is a string, the value is a string
    
    var taskArray: [TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let task1: Dictionary<String,String> = ["task": "Study French", "subtask": "Verbs", "date":"01.12.2014"]
//        let task2:Dictionary<String, String> = ["task": "Eat Dinner", "subtask": "Burgers", "date": "01.12.2014"]
//        let task3:Dictionary<String, String> = ["task": "Gym", "subtask": "Leg day", "date": "01.12.2014"]
//        taskArray = [task1, task2, task3]
        
        let date1 = Date.from(year: 2014, month: 12, day: 1)
        let date2 = Date.from(year: 2014, month: 12, day: 3)
        let date3 = Date.from(year: 2014, month: 5, day: 12)
        
        
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: date1)
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date:  date2)
        
        taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Led day", date:  date3)]
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = taskArray[indexPath!.row]
            detailVC.detailTaskModel = thisTask
        }
        
    }
    
    //UITableViewDataSource (how many rows should it have and what should it have in each row/cell
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        let thisTask = taskArray[indexPath.row]
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subTask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        return cell
        
        
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //when tapping on a certain row in the table
        
        println(indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
        
    }


}

