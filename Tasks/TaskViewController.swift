//
//  TaskViewController.swift
//  Tasks
//
//  Created by Kavindu Hansajith on 2024-09-26.
//
//
//import UIKit
//
//class TaskViewController: UIViewController {
//    @IBOutlet var label: UILabel!
//    
//    var taskIndex: Int? // To store the index of the current task
//
//    
//    var task: String?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        label.text = task
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "delete", style: .done, target: self, action: #selector(deleteTask))
//    }
//    
//    @objc func deleteTask(){
//        
//        
//        
//        
//        
//        
//        
//        
////        let newCount = count - 1
////        
////        UserDefaults().setValue(newCount, forKey: "count")
////        UserDefaults().setValue(nill, forKey: "task_\(currentPosition)")
////        
//        
//        
//    }
//
//
//}


//
//  TaskViewController.swift
//  Tasks
//
//  Created by Kavindu Hansajith on 2024-09-26.
//
import UIKit

class TaskViewController: UIViewController {
    @IBOutlet var label: UILabel!

    var task: String?
    var taskIndex: Int?

    // Closure to notify ViewController when a task is deleted
    var onDeleteTask: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = task
        label.numberOfLines = 0 // Allow multiple lines

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    

    // ... rest of your TaskViewController code
}

    @objc func deleteTask() {
        guard let taskIndex = taskIndex else { return }

        let alertController = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this task?", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // Handle cancel action
        }

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            // Handle delete action
            let count = UserDefaults().integer(forKey: "count")

            if taskIndex >= count {
                self.navigationController?.popViewController(animated: true)
                return
            }

            let newCount = count - 1
            UserDefaults().setValue(newCount, forKey: "count")
            UserDefaults().setValue(nil, forKey: "task_\(taskIndex + 1)")

            // Shift remaining tasks if necessary
            if taskIndex < newCount {
                for i in taskIndex + 1...newCount {
                    if let task = UserDefaults().value(forKey: "task_\(i + 1)") as? String {
                        UserDefaults().setValue(task, forKey: "task_\(i)")
                    }
                }
            }

            // Clear the last task slot
            UserDefaults().setValue(nil, forKey: "task_\(count)")

            // Notify ViewController about the deletion
            self.onDeleteTask?()

            // Go back to task list after deletion
            self.navigationController?.popViewController(animated: true)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    
    
    }
}
