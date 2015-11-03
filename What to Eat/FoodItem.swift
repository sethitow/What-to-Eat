//
//  FoodItem.swift
//  What to Eat
//
//  Created by Seth Itow on 10/10/15.
//  Copyright © 2015 Seth Itow. All rights reserved.
//

import UIKit

class FoodItem: NSObject {
    

    init(title: String,
        foodDescription: String,
        location: String,
        locationID: String,
        openingTime: NSDate,
        closingTime: NSDate,
        mealOfDayString: String,
        imageName: String) {
            
        self.title = title
        self.foodDescription = foodDescription
        self.location = location
        self.locationID = locationID
        self.openingTime = openingTime
        self.closingTime = closingTime
        self.validDate = NSDate(timeIntervalSinceReferenceDate: NSTimeInterval(270*60))
        self.mealOfDay = Meals(rawValue: mealOfDayString)!
        self.foodImage = UIImage(named: imageName)
        
                    }
    
    
//Variables
    var title: String // big title of food item
    var foodDescription: String // description of food item
    var location: String // where the food item can be purchased
    var locationID: String
    var closingTime: NSDate // NSDate object that represents the instance of when the dish begins being served
    var openingTime: NSDate // NSDate object that represents the instance of when the dish begins being served
    var mealOfDay: Meals // Enum to keep track of what meal
   
    var foodImage: UIImage?
    
    var validDate: NSDate
    
    
    

    
    func getClosingTimeAsMinutes() -> Int{
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: closingTime)
        let hour = components.hour
        let minutes = components.minute
        
        return hour*60 + minutes
    }
    
    

}
