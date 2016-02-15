//
//  PrayerManager.swift
//  Al ADAN
//
//  Created by Hamza El Aidi on 1/19/16.
//  Copyright © 2016 Hamza El Aidi. All rights reserved.
//

import Foundation
class PrayerManager{
    var prayersName = ["asobh", "adohr", "alasr", "almaghrib", "al3icha"]
    var prayersDuaa = [String]()
    var prayer : Prayer!
    var prayers = [Prayer]()
    ////////////// Get all prayer Times
    func getPrayerTimes()->[String] {
        
        let myWebSiteURL = NSURL(string: "http://www.lematin.ma/horaire-priere-casablanca.html")
        myWebSiteURL?.absoluteString
        if let myHTMLString = try? String(contentsOfURL: myWebSiteURL!, encoding: NSUTF8StringEncoding){
            let pattern = "\\d?\\d:\\d\\d"
            let regx = try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
            
            var results = regx.matchesInString(myHTMLString, options: [], range: NSMakeRange(0, myHTMLString.characters.count))
            
            results.removeFirst()
            results.removeAtIndex(9)
            results.removeAtIndex(8)
            results.removeAtIndex(7)
            results.removeAtIndex(6)
            results.removeAtIndex(5)
            
            return results.map {
                let range = $0.range
                return (myHTMLString as NSString).substringWithRange(range)
            }
        }
        return [String]()
    }
    
    func makePrayers(){
        
        prayer = Prayer()
        let prayersTime = getPrayerTimes()
        
        for i in 0...(prayersTime.count-1){
            
            prayer.name = prayersName[i]
            prayer.time = prayersTime[i]
            prayer.duaa = prayersDuaa[i]
            prayers.append(prayer)
        }
    }
    //////////// Get Next Prayer
    func getNextPrayer()->Prayer{
       
        for prayer in prayers{
            
                let interval = prayer.date.timeIntervalSinceNow
                
                if interval > 0 {
                    return prayer
                    
                }
        }
        return prayer
    }
    
    ////////// Get Duaa from text file
    func getDuaas()->[String]{
        var prayersDuaa = [String]()
        let path = NSBundle.mainBundle().pathForResource("duaa", ofType: "txt")
        let filemgr = NSFileManager.defaultManager()
        if filemgr.fileExistsAtPath(path!){
            let duaas = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            prayersDuaa = duaas.componentsSeparatedByString("\n")
            for i in prayersDuaa{
                print(i)
            }
        }
        return prayersDuaa
    }
    
    init(){
        prayersDuaa = getDuaas()
    }
}
















