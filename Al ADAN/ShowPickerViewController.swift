//
//  ShowPickerViewController.swift
//  Al ADAN
//
//  Created by Hamza El Aidi on 1/12/16.
//  Copyright © 2016 Hamza El Aidi. All rights reserved.
//

import UIKit

class ShowPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var pickerView: UIPickerView!
    var adanVoiceArray = ["al fasy adhan", "Masjid Aqsa adhan", "Turkey adhan", "mecca adhan", "malaysia adhan", "pakistan adhan", "indonesia athan", "adan", "adan1", "adan2", "adan3", "adan4", "adan5"]
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        pickerView.delegate = self
        pickerView.dataSource = self
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        //view.opaque = false
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return adanVoiceArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return adanVoiceArray.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func getChosenAdan(sender: AnyObject) {
        
        defaults.setObject(adanVoiceArray[pickerView.selectedRowInComponent(0)], forKey: "selectedAdan")
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    @IBAction func exitAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }

}
