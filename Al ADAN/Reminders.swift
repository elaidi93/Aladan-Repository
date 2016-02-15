//
//  Reminders.swift
//  Al ADAN
//
//  Created by Hamza El Aidi on 2/4/16.
//  Copyright © 2016 Hamza El Aidi. All rights reserved.
//

import Foundation

class Reminder : NSObject, NSCoding{
    var descript : String!
    var date : NSDate!
    
    init(descript : String, date: NSDate){
        self.descript = descript
        self.date = date
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let descript = aDecoder.decodeObjectForKey("descript") as! String
        let date = aDecoder.decodeObjectForKey("date") as! NSDate
        self.init(descript: descript, date: date)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.descript, forKey: "descript")
        aCoder.encodeObject(self.date, forKey: "date")
    }
    
}