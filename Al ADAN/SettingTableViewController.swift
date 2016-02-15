//
//  SettingTableViewController.swift
//  Al ADAN
//
//  Created by Hamza El Aidi on 12/31/15.
//  Copyright © 2015 Hamza El Aidi. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    
    @IBOutlet weak var SliderValueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var selectedAdanLabel: UILabel!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Settings"
        selectedAdanLabel.text = defaults.stringForKey("selectedAdan")
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.section == 1 && indexPath.row == 3){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("ShowPicker")
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func SliderMoving(sender: AnyObject) {
        
        SliderValueLabel.text = "\(Int(slider.value)) min"
        defaults.setObject(slider.value, forKey: "sliderValue")
        
    }
    
    @IBAction func switchAction(sender: AnyObject) {
    
        print(mySwitch.on)
        defaults.setObject(mySwitch.on , forKey: "SwitchAction")
        
    }
    
}














