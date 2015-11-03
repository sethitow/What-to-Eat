//
//  LocationItem.swift
//  What to Eat
//
//  Created by Seth Itow on 10/11/15.
//  Copyright © 2015 Seth Itow. All rights reserved.
//

import UIKit

class LocationItem: NSObject {
    
    
    init(locationTitle: String,
        locationDescription: String,
        locationID: String,
        breakfastHoursString: String,
        lunchHoursString:String,
        dinnerHoursString:String,
        locationLine1:String,
        locationLine2:String,
        locationLine3:String,
        locationLat: Double,
        locationLon: Double) {
        
        self.locationTitle = locationTitle
        self.locationDescription = locationDescription
        self.locationID = locationID
            
        self.breakfastHoursString = breakfastHoursString
        self.lunchHoursString = lunchHoursString
        self.dinnerHoursString = dinnerHoursString
            
        self.locationLine1 = locationLine1
        self.locationLine2 = locationLine2
        self.locationLine3 = locationLine3
            
        self.locationLat = locationLat
        self.locationLon = locationLon
        
    }
    

    var locationTitle: String
    var locationDescription: String
    var locationID: String
    
    var breakfastHoursString: String
    var lunchHoursString: String
    var dinnerHoursString: String
    
    var locationLine1: String
    var locationLine2: String
    var locationLine3: String
    
    var locationLat: Double
    var locationLon: Double
    
    
}
