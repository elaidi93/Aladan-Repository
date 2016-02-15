//
//  ReminderOptionsViewController.swift
//  Al ADAN
//
//  Created by Hamza El Aidi on 2/4/16.
//  Copyright © 2016 Hamza El Aidi. All rights reserved.
//

import UIKit

protocol UpdateTableViewDelegate{
    
    func updateTableView()
    
}

class ReminderOptionsViewController: UIViewController {
    
    var reminder : Reminder!
    var reminders : [Reminder]!
    let setDefault = NSUserDefaults.standardUserDefaults()
    var delegate : UpdateTableViewDelegate?
    
    override func viewWillAppear(animated: Bool) {
        
        if let decodeData = setDefault.objectForKey("reminders"){
        
            reminders = NSKeyedUnarchiver.unarchiveObjectWithData(decodeData as! NSData) as! [Reminder]
        
        }else{
            
            reminders = [Reminder]()
            print("git test changing")
        }
        
    }
    
    @IBOutlet weak var remindDescription: UITextField!
    @IBOutlet weak var remindDate: UIDatePicker!
    
    @IBAction func confirmation(sender: AnyObject) {
        
        reminder = Reminder(descript: remindDescription.text!, date: remindDate.date)
        reminders.append(reminder)
        let encodeData = NSKeyedArchiver.archivedDataWithRootObject(reminders)
        
        setDefault.setObject(encodeData, forKey: "reminders")
        setDefault.synchronize()
        self.dismissViewControllerAnimated(false, completion: nil)
        
        delegate?.updateTableView()
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}











