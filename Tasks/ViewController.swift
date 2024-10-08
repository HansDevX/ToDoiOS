//
//  ViewController.swift
//  Tasks
//
//  Created by Kavindu Hansajith on 2024-09-25.
//

//import UIKit
//
//class ViewController: UIViewController {
//    
//    @IBOutlet var tableView: UITableView!
//    
//    var tasks = [String]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.title = "Tasks"
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        
//        // Setup
//        
//        
//        if !UserDefaults().bool(forKey: "setup") {
//            UserDefaults().setValue(true, forKey: "setup")
//            UserDefaults().setValue(0, forKey: "count")
//        }
//        
//        //Get all current saved task
//        updateTasks()
//    }
//    
//    func updateTasks() {
//        
//        tasks.removeAll()
//        
//        guard let count = UserDefaults().value(forKey: "count") as? Int else {
//            return
//        }
//        for x in 0..<count {
//            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
//                tasks.append(task)
//            }
//        }
//        
//        tableView.reloadData()
//    }
//    
//    @IBAction func didTapAdd() {
//        
//        
//        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
//        vc.title = "New Task"
//        vc.update = {
//            DispatchQueue.main.async{
//                self.updateTasks()
//            }
//        }
//        navigationController?.pushViewController(vc, animated: true)
//        
//    }
//    
//
//
//}
//
//
//
//
////extension ViewController: UITableViewDelegate {
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        tableView.deselectRow(at: indexPath, animated: true)
////        
////        
////        
////        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
////        vc.title = "New Task"
////        vc.task = tasks[indexPath.row]
////        
////        navigationController?.pushViewController(vc, animated: true)
////        
////        
////        
////    }
////    
////}
//
//
//
//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
//        vc.title = "New Task"
//        vc.task = tasks[indexPath.row]
//        vc.taskIndex = indexPath.row // Pass the task index
//        
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//
//
//extension ViewController: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tasks.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        
//        cell.textLabel?.text = tasks[indexPath.row]
//        
//        return cell
//    }
//    
//}



import UIKit
import Tasks // Assuming "Tasks" is the name of your module

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self

        // Setup
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().setValue(true, forKey: "setup")
            UserDefaults().setValue(0, forKey: "count")
        }

        // Get all current saved tasks
        updateTasks()
    }

    func updateTasks() {
        tasks.removeAll()

        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }

        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }

        tableView.reloadData()
    }

    @IBAction func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = storyboard?.instantiateViewController(identifier: "task") as! Tasks.TaskViewController // Use fully qualified name
        vc.title = "Task"
        vc.task = tasks[indexPath.row]
        vc.taskIndex = indexPath.row

        // Set the onDeleteTask closure to update the tasks after deletion
        vc.onDeleteTask = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}
