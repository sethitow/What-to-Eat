//
//  foodItemController.swift
//  What to Eat
//
//  Created by Seth Itow on 11/1/15.
//  Copyright © 2015 Seth Itow. All rights reserved.
//

import UIKit

class FoodItemController: NSObject {
    
    static let sharedInstance = FoodItemController()
    
    var allFoodItems = [FoodItem]()
    
    //commented out due to depricated date format
//    func updateDataWithDummyData(){
//        
//        allFoodItems.removeAll()
//        
//        allFoodItems.append(FoodItem(
//            title: "Grilled chicken breast",
//            foodDescription: "over spinach salad with roasted shallot-balsamic",
//            location: "Local Point, Big Kitchen",
//            locationID: "The Big Kitchen",
//            openingTime: 990,
//            closingTime: 1230,
//            mealOfDayString: "dinner",
//            imageName: "grilledchicken.jpeg"))
//        
//        allFoodItems.append(FoodItem(
//            title: "Thai Red Curry",
//            foodDescription: "with chicken or tofu",
//            location: "Local Point, Big Kitchen",
//            locationID: "The Big Kitchen",
//            openingTime: 990,
//            closingTime: 1230,
//            mealOfDayString: "dinner",
//            imageName: "redthaicurry.jpeg"))
//        
//        allFoodItems.append(FoodItem(
//            title: "Chicago Style Beef Sandwich",
//            foodDescription: "with giardiniera vegetables and spicy au jus and house-fried chips",
//            location: "Local Point, Global Kitchen",
//            locationID: "The Global Kitchen",
//            openingTime: 990,
//            closingTime: 1230,
//            mealOfDayString: "dinner",
//            imageName: "chicagobeef.jpeg"))
//        
//        allFoodItems.append(FoodItem(
//            title: "Stovetop Mac and Cheese",
//            foodDescription: "Add your own ingredients, blah",
//            location: "Local Point, Custom Kitchen",
//            locationID: "The Custom Kitchen",
//            openingTime: 990,
//            closingTime: 1230,
//            mealOfDayString: "dinner",
//            imageName: "macncheese.jpeg"))
//        
//        allFoodItems.append(FoodItem(
//            title: "Stovetop Mac and Cheese",
//            foodDescription: "Add your own ingredients, blah",
//            location: "Local Point, Custom Kitchen",
//            locationID: "The Custom Kitchen",
//            openingTime: 990,
//            closingTime: 1230,
//            mealOfDayString: "dinner",
//            imageName: "macncheese.jpeg"))
//        
//        allFoodItems.append(FoodItem(
//            title: "Big Kahuna Burger",
//            foodDescription: "A tasty burger",
//            location: "Local Point, Custom Kitchen",
//            locationID: "The Custom Kitchen",
//            openingTime: 990,
//            closingTime: 1230,
//            mealOfDayString: "dinner",
//            imageName: "tastyburger.jpeg"))
//        
//    }
    
    func updateDataFromWeb(){
        
        // attempt to fetch the JSON file from the server
        if let dataFromWeb = NSData(contentsOfURL: NSURL(string: "http://students.washington.edu/sethitow/localpoint-2015-11-1.json")!){
        
            allFoodItems.removeAll() // clear the allFoodItems array
        
            let json = JSON(data: dataFromWeb) //create a SwiftyJSON object
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            var index: Int // create integer for For loop
            let length = json["foodItems"].count // get length for For loop
            for index = 0;index<length;++index {
                
                
                
                allFoodItems.append(FoodItem(
                    title: json["foodItems"][index]["foodTitle"].stringValue,
                    foodDescription: json["foodItems"][index]["foodDescription"].stringValue,
                    location: json["foodItems"][index]["location"].stringValue,
                    locationID: json["foodItems"][index]["location"].stringValue,
                    openingTime: dateFormatter.dateFromString(json["foodItems"][index]["openTime"].stringValue)!,
                    closingTime: dateFormatter.dateFromString(json["foodItems"][index]["closeTime"].stringValue)!,
                    mealOfDayString: json["foodItems"][index]["mealOfDay"].stringValue,
                    imageName: json["foodItems"][index]["imageName"].stringValue))
                
            }
            
            
        
            
        }
        
        else{
            
            //unable to get food items
        }
        
    }
    
    func returnNowFoodItems() -> [FoodItem] {
        
        let now = NSDate() // create date object representing current instant
        
        var nowFoodItems = [FoodItem]() // create array of all food item open now
        
        for item in allFoodItems{ // for every food item in allFoodItems
            
            if (now.isGreaterThanDate(item.openingTime) && now.isLessThanDate(item.closingTime)){ // if the food item is between the current time
            nowFoodItems.append(item) //add it to the array
            }
        }
        
        
        return nowFoodItems // return the array
    }
    
    func returnAllFoodItems() -> [FoodItem] {
        
        
        return allFoodItems
    }


}
