//
//  PrayerTableViewController.swift
//  Al ADAN
//
//  Created by Hamza El Aidi on 12/23/15.
//  Copyright © 2015 Hamza El Aidi. All rights reserved.
//

import UIKit
import AVFoundation

class PrayerTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var prayerManager = PrayerManager()
    var timeCallNotif = NSTimer()
    var prayers = [Prayer]()
    var nextPrayer : Prayer!
    var audioPlayer = AVAudioPlayer()
    var adanPath : NSURL!

    override func viewDidLoad() {
        jsonContent()
        prayerManager.makePrayers()
        prayers = prayerManager.prayers
        nextPrayer = prayerManager.getNextPrayer()
        tabBarController!.tabBar.items![0].title = "Salati"
        updateTitle()
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTitle", userInfo: nil, repeats: true)
        if(defaults.objectForKey("SwitchAction") == nil){
            defaults.setObject(true, forKey: "SwitchAction")
        }
        if(defaults.objectForKey("selectedAdan") == nil){
            defaults.setObject("adan", forKey: "selectedAdan")
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        adanPath = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource(defaults.stringForKey("selectedAdan"), ofType: "mp3")!)
        
        timeCallNotif = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timeCallNotification"), userInfo: nil, repeats: true)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PrayerCell", forIndexPath: indexPath) as! PrayerTableViewCell
        let prayerListIndex = prayers[indexPath.row]
        let image = UIImage(named: prayerListIndex.name)
        cell.prayerName.text = prayerListIndex.name
        cell.prayerTime.text = prayerListIndex.time
        cell.prayerImage.image = image
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayers.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /////////Update Title
    
    func updateTitle() {
        
        navigationItem.title = NSLocalizedString("Next Prayer \(nextPrayer.name) \(nextPrayer.formatedDate)", comment: "Next prayer count down")
    }
    
    ////////// Send Selected Prayer Information to PrayerInfo
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sendToPrayerInfo = segue.destinationViewController as! PrayerInfoViewController
        
        if let indexPath = self.tableView.indexPathForSelectedRow{
            
            let selectedPrayer = prayers[indexPath.row]
            sendToPrayerInfo.currentPrayer = selectedPrayer
        }
        
    }
    
    ////////////verify if it's time to notify
    func timeCallNotification(){
        if(Int(nextPrayer.date.timeIntervalSinceNow) == 1){
            Notification()
        }
    }
    /////////////Notification
    func Notification(){
        
        let Notification = UILocalNotification()
        Notification.alertAction = NSLocalizedString("Prayer Time", comment: "Notification Title")
        Notification.alertBody = NSLocalizedString("It's Time for \(nextPrayer.name)", comment: "Notification Body")
        Notification.fireDate = NSDate(timeIntervalSinceNow: (nextPrayer.date.timeIntervalSinceNow - defaults.doubleForKey("sliderValue")))
        UIApplication.sharedApplication().scheduleLocalNotification(Notification)
        
        if(defaults.boolForKey("SwitchAction") == true){
            
            adanPlayer()
        }
        nextPrayer = prayerManager.getNextPrayer()
    }
    
    /////////////Player
    func adanPlayer(){
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: adanPath)
        audioPlayer.play()
    }
    
    ////////////Get Jason Content
    func jsonContent(){
        let path = NSBundle.mainBundle().pathForResource("JsonFile", ofType: "json")
        print(path)
        let jasonData = NSData(contentsOfFile: path!) as NSData!
        let readableJson = try! NSJSONSerialization.JSONObjectWithData(jasonData!, options: .MutableContainers)
        print(readableJson)
        
    }
    
    //////////// show parametre as popOver
    @IBAction func showParametrePopOver(sender: AnyObject) {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("parametre") as! SettingTableViewController
        vc.preferredContentSize = CGSize(width: UIScreen.mainScreen().bounds.width / 2, height: UIScreen.mainScreen().bounds.height / 2)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        let popOver = navController.popoverPresentationController
        popOver?.delegate = self
        popOver?.barButtonItem = sender as? UIBarButtonItem
        
        self.presentViewController(navController, animated: true, completion: nil)
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
}




























