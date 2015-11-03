//
//  sharedCode.swift
//  What to Eat
//
//  Created by Seth Itow on 11/2/15.
//  Copyright © 2015 Seth Itow. All rights reserved.
//

import Foundation

enum Meals: String {
    case breakfast = "breakfast"
    case brunch = "brunch"
    case lunch = "lunch"
    case dinner = "dinner"
    case allDay = "allDay"
}

extension NSDate
{
    func isGreaterThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    
    func isLessThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
        {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    
//    func isEqualToDate(dateToCompare : NSDate) -> Bool
//    {
//        //Declare Variables
//        var isEqualTo = false
//        
//        //Compare Values
//        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame
//        {
//            isEqualTo = true
//        }
//        
//        //Return Result
//        return isEqualTo
//    }
}