//
//  Date.swift
//  TaskIt
//
//  Created by Benjamin Brühl on 17.11.14.
//  Copyright (c) 2014 self.edu. All rights reserved.
//

import Foundation
import UIKit

class Date {
    
    class func from (#year: Int, month: Int, day: Int) -> NSDate {
        
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
        var date = gregorianCalendar?.dateFromComponents(components)
        
        return date!
    }
    
    class func toString (#date:NSDate) -> String {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateStringFormatter.stringFromDate(date)
        
        return dateString
    }
}