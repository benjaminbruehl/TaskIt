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
    
    var baseArray:[[TaskModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let task1: Dictionary<String,String> = ["task": "Study French", "subtask": "Verbs", "date":"01.12.2014"]
//        let task2: Dictionary<String, String> = ["task": "Eat Dinner", "subtask": "Burgers", "date": "01.12.2014"]
//        let task3: Dictionary<String, String> = ["task": "Gym", "subtask": "Leg day", "date": "01.12.2014"]
//        taskArray = [task1, task2, task3]
        
        let date1 = Date.from(year: 2014, month: 12, day: 1)
        let date2 = Date.from(year: 2014, month: 12, day: 3)
        let date3 = Date.from(year: 2014, month: 5, day: 12)
        
        
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: date1, isCompleted: false)
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date:  date2, isCompleted: false)
        
        let incompleteTaskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Led day", date:  date3, isCompleted: false)]
        
        var completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, isCompleted: true)]
        
        baseArray = [incompleteTaskArray, completedArray]
        
        self.tableView.reloadData()
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        func sortByDate(taskOne:TaskModel, taskTwo:TaskModel) -> Bool {
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
//        
//        taskArray.sorted(sortByDate)
        
        baseArray[0] = baseArray[0].sorted{
            (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            //comparison logic takes place automatically via "sorted"
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        
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
            let thisTask = baseArray[indexPath!.section][indexPath!.row]
            detailVC.detailTaskModel = thisTask
            detailVC.mainVC = self
        }
        
        if segue.identifier == "showTaskAdd" {
            let addTaskVC: AddTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskVC.mainVC = self
        }
        
    }
    
    @IBAction func addTaskButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    //UITableViewDataSource (how many rows should it have and what should it have in each row/cell
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
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
    
    
    //Height of headers
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    //Headers of sections
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do"
        }
        else {
            return "Completed"
        }
    }
    
    //Text upon swiping
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        if indexPath.section == 0 {
            return "Done"
        }
        else {
            return "To Do"
        }
    }

    
    // what happens on swipe:
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, isCompleted: true)
            baseArray[1].append(newTask)
        }
        else {
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, isCompleted: false)
            baseArray[0].append(newTask)
        }
        
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        tableView.reloadData()

    }
    
    


}

