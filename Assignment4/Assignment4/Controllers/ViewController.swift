//
//  ViewController.swift
//  Assignment4
//
//  Created by tanaka on 2/19/19.
//  Copyright © 2019 tanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    
    
    @IBOutlet weak var descriptionInput: UITextField!
    
    @IBOutlet weak var stateSegmentControl: UISegmentedControl!
    @IBOutlet weak var prioritySegmentControl: UISegmentedControl!
    @IBOutlet weak var emojiInput: UITextField!
    var priority = "High"
    var state = "Open"
    var todoItem: TodoItem?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        if let todoItem = todoItem {
            descriptionInput.text = todoItem.description
            switch todoItem.priority{
            case "High":
                prioritySegmentControl.selectedSegmentIndex = 0
            case "Medium":
                prioritySegmentControl.selectedSegmentIndex = 1
            case "Low":
                prioritySegmentControl.selectedSegmentIndex = 2
            default:
                break
            }
            
           
            emojiInput.text = todoItem.emoji
            switch todoItem.state{
            case "Open":
                stateSegmentControl.selectedSegmentIndex = 0
            case "Closed":
                stateSegmentControl.selectedSegmentIndex = 1
            default:
                break
            }
           
            
            
            
        }else {
            
        }
        
            
    }

    @IBAction func prioritySegmentChanged(_ sender: Any) {
        switch prioritySegmentControl.selectedSegmentIndex{
        case 0:
            priority = "High"
        case 1:
            priority = "Medium"
        case 2:
            priority = "Low"
        default:
            break
        }
    }
    @IBAction func stateSegmentChanged(_ sender: Any) {
        switch stateSegmentControl.selectedSegmentIndex {
        case 0:
            state = "Open"
        case 1:
            state = "Closed"
        default:
            break
        }
    }
    @IBAction func saveButtonTouched(_ sender: UIBarButtonItem) {
        
        //code tosave or add new
        // navigate back
       // if descriptionInput.text != "" {
        
        
        if let todoItem = self.todoItem {
            //edit
            if let newDescription = descriptionInput.text {
                todoItem.description = newDescription
            }
            if let newEmoji = emojiInput.text {
                todoItem.emoji = newEmoji
            }
            todoItem.priority = priority
            todoItem.state = state
            
            
        }
        else {
            if let newDescription = descriptionInput.text, let newEmoji = emojiInput.text {
                TodoItemManager.instance.todoItems.append(TodoItem(description: newDescription, emoji: newEmoji, priority: Priority(rawValue: priority)!,  state: State(rawValue: state)!))
                descriptionInput.text = ""
                
            }
            else {
                print("some data not entered")
            }
            
        }
        TodoItemManager.instance.save()//added this because if you clicked save button but didnt exit out of app and just stopped the simulator running it wouldnt save
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

