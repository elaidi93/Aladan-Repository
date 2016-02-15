//
//  ReminderTableViewController.swift
//  Al ADAN
//
//  Created by Hamza El Aidi on 2/4/16.
//  Copyright © 2016 Hamza El Aidi. All rights reserved.
//

import UIKit
import AVFoundation


class ReminderTableViewController: UITableViewController, UpdateTableViewDelegate {
    
    let getDefault = NSUserDefaults.standardUserDefaults()
    var reminders = [Reminder]()
    var deleteReminderIndexPath : NSIndexPath!
    //var mz = MZFormSheetPresentationController()
    var reminderController : ReminderOptionsViewController!
    
    override func viewDidLoad() {
        reminderController = self.storyboard?.instantiateViewControllerWithIdentifier("formSheetController") as! ReminderOptionsViewController
        reminderController.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        reloadReminders()
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeCallNotification", userInfo: nil, repeats: true)
        
    }
    
    func updateTableView() {
        reloadReminders()
        tableView.reloadData()
    }
    
    func reloadReminders(){
    
        if((getDefault.objectForKey("reminders")) != nil){
            let decodeData = getDefault.objectForKey("reminders") as! NSData
            reminders = NSKeyedUnarchiver.unarchiveObjectWithData(decodeData) as! [Reminder]
        }
        
    }
    
    
    // MARK: call addForm
    @IBAction func callAdRemindFormSheet(sender: AnyObject) {
        
        let formSheetController = MZFormSheetPresentationViewController(contentViewController: reminderController)
        
        formSheetController.willPresentContentViewControllerHandler = { [weak formSheetController] (value: UIViewController)  -> Void in
            if let weakController = formSheetController {
                weakController.contentViewCornerRadius = 5.0
                weakController.shadowRadius = 6.0
            }
        }
        
        self.presentViewController(formSheetController, animated: true, completion: nil)
        tableView.reloadData()
    }
    
    // MARK: TableView
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ReminderTableViewCell
        let reminder = reminders[indexPath.row]
        
        cell.remindDesc.text = "\(reminder.descript)"
        cell.remindDate.text = "\(NSDateFormatter.localizedStringFromDate(reminder.date, dateStyle: NSDateFormatterStyle.FullStyle, timeStyle: NSDateFormatterStyle.MediumStyle))"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: Active Delete option
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deleteReminderIndexPath = indexPath
            let reminderToDelete = reminders[indexPath.row]
            confirmDelete(reminderToDelete)
        }
    }
    
    // MARK: Delete Confirmation with ActionSheet
    func confirmDelete(planet: Reminder) {
        let alert = UIAlertController(title: "Delete Reminder", message: "Are you sure you want to permanently delete \(reminders[deleteReminderIndexPath.row].descript)?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteReminder)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteReminder)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeleteReminder(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteReminderIndexPath {
            tableView.beginUpdates()
            
            reminders.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            deleteReminderIndexPath = nil
            tableView.endUpdates()
            
            let encodeData = NSKeyedArchiver.archivedDataWithRootObject(reminders)
            
            getDefault.setObject(encodeData, forKey: "reminders")
        }
    }
    
    func cancelDeleteReminder(alertAction: UIAlertAction!) {
        deleteReminderIndexPath = nil
    }
    
    
    
    ////////////verify if it's time to notify
    func timeCallNotification(){
        for reminder in reminders{
            if(Int(reminder.date.timeIntervalSinceNow) == -5){
                Notification(reminder)
            }
        }
    }
    
    /////////////Notification
    func Notification(reminder: Reminder){
        
        let Notification = UILocalNotification()
        Notification.alertAction = "hey there"
        Notification.alertBody = "you have something to do"
        Notification.fireDate = NSDate(timeIntervalSinceNow: (reminder.date.timeIntervalSinceNow))
        UIApplication.sharedApplication().scheduleLocalNotification(Notification)
        
    }
    
}















