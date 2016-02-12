//
//  PrayerClass.swift
//  Al ADAN
//
//  Created by Hamza El Aidi on 12/23/15.
//  Copyright © 2015 Hamza El Aidi. All rights reserved.
//

import Foundation
struct Prayer{

    var name : String
    var time : String // stringTime
    var duaa : String
    var date : NSDate{
        get{
            let calendar = NSCalendar.currentCalendar()
            let CurrentDateComponents = calendar.components( [.Month, .Year, .Day], fromDate:  NSDate())
            
            let dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "HH:mm"
            
            let newDate = dateFormater.dateFromString(self.time)
            
            let c = calendar.components([.Hour, .Minute, .Month, .Year, .Day], fromDate: newDate!)
            c.year = CurrentDateComponents.year
            c.month = CurrentDateComponents.month
            c.day = CurrentDateComponents.day
            
            return calendar.dateFromComponents(c)!
        }
    }
    
    ///////Show convert millisecond to hour:minute:second
    
    func stringFromTimeInterval(date: NSDate) -> String {
        var date = date
        var interval = date.timeIntervalSinceNow
        
        if interval < 0{
            date = date.dateByAddingTimeInterval(86400)
            interval = date.timeIntervalSinceNow
        }
        
        let seconds = Int((interval % 3600) % 60)
        let minutes = Int((interval % 3600) / 60)
        let hours = Int((interval / 3600))
        
        return String(format: "\(hours)h:\(minutes)m:\(seconds)s")
    }
    
    init(){
        name = ""
        time = "00:00"
        duaa = ""
    }
    
}






















