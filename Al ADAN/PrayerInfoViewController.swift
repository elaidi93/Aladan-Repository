//
//  ShowViewController.swift
//  Al ADAN
//
//  Created by Hamza El Aidi on 12/28/15.
//  Copyright © 2015 Hamza El Aidi. All rights reserved.
//

import UIKit

class PrayerInfoViewController: UIViewController {
    
    var prayerManager = PrayerManager()
    var currentPrayer : Prayer?
    var currentPrayerDate : NSDate!
    
    @IBOutlet weak var infoPrayerImage: UIImageView!
    @IBOutlet weak var infoPrayerName: UILabel!
    @IBOutlet weak var infoPrayerTime: UILabel!
    @IBOutlet weak var infoPrayerRestTime: UILabel!
    @IBOutlet weak var infoPrayerDuaa: UILabel!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prayerManager.makePrayers()
        if(currentPrayer == nil){
            currentPrayer = prayerManager.prayers[0]
        }
        
        updateTime()
        updateUI()
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        
    }
    
   /////////show in label
    
    func updateTime() {
        infoPrayerRestTime.text = currentPrayer!.formatedDate
    }

    func updateUI(){
        let image = UIImage(named: currentPrayer!.name)
        infoPrayerImage.image = image
        infoPrayerName.text = currentPrayer!.name
        infoPrayerTime.text = currentPrayer!.time
        infoPrayerDuaa.text = currentPrayer!.duaa
        
        self.title = currentPrayer!.name
    }
    
}
