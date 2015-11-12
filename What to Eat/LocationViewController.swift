//
//  LocationViewController.swift
//  What to Eat
//
//  Created by Seth Itow on 10/11/15.
//  Copyright © 2015 Seth Itow. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var locationTableView: UITableView!
    
    var receivedLocation:String?
    
    var locationItems = [LocationItem]()
    var foodItems = [FoodItem]()
    var filteredLocations = [LocationItem]()
    var filteredFoodItems = [FoodItem]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTableView.dataSource = self
        locationTableView.delegate = self
        locationTableView.registerClass(LocationItemCell.self, forCellReuseIdentifier: "locationItemCell")
        locationTableView.rowHeight = UITableViewAutomaticDimension
        
        if locationItems.count > 0 {return} // if the array already has data, skip
        
        locationItems.append(LocationItem(
            locationTitle: "The Big Kitchen",
            locationDescription: "serves wholesome meals reminiscent of home, wherever home may be.",
            locationID: "The Big Kitchen",
            breakfastHoursString: "7:30 AM to 10 AM",
            //breakfastOpenTime: 450,
            //breakfastCloseTime: 600,
            lunchHoursString:"10:30 AM to 2:30 PM",
            //lunchOpenTime: 630,
            //lunchCloseTime: 870,
            dinnerHoursString:"4:30 PM to 8:30 PM",
            //dinnerOpenTime:990,
            //dinnerCloseTime:1230,
            locationLine1:"Lander Hall",
            locationLine2:"1201 NE Campus Parkway",
            locationLine3:"Seattle, WA 98105",
            locationLat: 47.655819,
            locationLon: -122.314950))
        
        locationItems.append(LocationItem(
            locationTitle: "The Global Kitchen",
            locationDescription: "is one of the most versatile and eclectic dining destinations on campus. The menu rotates weekly.",
            locationID: "The Global Kitchen",
            breakfastHoursString: "Closed.",
            lunchHoursString:"10:30 AM to 2:30 PM",
            dinnerHoursString:"4:30 PM to 8:30 PM",
            locationLine1:"Lander Hall",
            locationLine2:"1201 NE Campus Parkway",
            locationLine3:"Seattle, WA 98105",
            locationLat: 47.655819,
            locationLon: -122.314950))
        
        locationItems.append(LocationItem(
            locationTitle: "The Custom Kitchen",
            locationDescription: "is a place to have things your way. Stop by during the week to prepare your own dish.",
            locationID: "The Custom Kitchen",
            breakfastHoursString: "7:30 AM to 10 AM",
            lunchHoursString:"10:30 AM to 2:30 PM",
            dinnerHoursString:"4:30 PM to 8:30 PM",
            locationLine1:"Lander Hall",
            locationLine2:"1201 NE Campus Parkway",
            locationLine3:"Seattle, WA 98105",
            locationLat: 47.655819,
            locationLon: -122.314950))
        
        locationItems.append(LocationItem(
            locationTitle: "The Grill",
            locationDescription: "serves classic cheeseburgers, grilled chicken sandwiches and a savory mushroom burger.",
            locationID: "The Grill",
            breakfastHoursString: "Closed.",
            lunchHoursString:"10:30 AM to 2:30 PM",
            dinnerHoursString:"4:30 PM to 8:30 PM",
            locationLine1:"Lander Hall",
            locationLine2:"1201 NE Campus Parkway",
            locationLine3:"Seattle, WA 98105",
            locationLat: 47.655819,
            locationLon: -122.314950))
        

        let locationPredicate = NSPredicate(format: "locationID contains[c] %@", receivedLocation!)
        let foodPredicate = NSPredicate(format: "locationID contains[c] %@", receivedLocation!)
        filteredLocations.append(((locationItems as NSArray).filteredArrayUsingPredicate(locationPredicate)).first as! LocationItem)
        filteredFoodItems = (foodItems as NSArray).filteredArrayUsingPredicate(foodPredicate) as! [FoodItem]
        
        


        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellCount = 1 + filteredFoodItems.count // 1 location cell + all of the food items at that location
        return cellCount
    }
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationItemCell",forIndexPath: indexPath) as! LocationItemCell
        let item = filteredLocations[indexPath.row]
        
        // set the cell labels to the strings retreived from the location object
        cell.locationTitle.text = receivedLocation!
        
        cell.locationDescription.text = item.locationDescription
        
        cell.breakfastHoursString.text = item.breakfastHoursString
        cell.lunchHoursString.text = item.lunchHoursString
        cell.dinnerHoursString.text = item.dinnerHoursString
        
        cell.locationLine1.text = item.locationLine1
        cell.locationLine2.text = item.locationLine2
        cell.locationLine3.text = item.locationLine3
        
        //set up mapLocation and create annotation at mapLocation
        let mapLocation = CLLocation(latitude: item.locationLat, longitude: item.locationLon)
        let regionRadius: CLLocationDistance = 500
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapLocation.coordinate, regionRadius, regionRadius)
        let annotation = MKPointAnnotation.init()
        annotation.coordinate = mapLocation.coordinate
        
        // zoom into the map region and add the annotation (pin)
        cell.mapView.setRegion(coordinateRegion, animated: false)
        cell.mapView.addAnnotation(annotation)
        
        return cell
        }
        
        else{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("FoodItemCell",forIndexPath: indexPath) as! FoodItemCell
            let item = filteredFoodItems[indexPath.row - 1]
            
            cell.titleLabel.text = item.title // set cell title label to the title of the dish
            
            cell.descriptionLabel.text = item.foodDescription // set cell description label to the description of the dish
            
            cell.locationLabel.text = item.location // set cell location label to the location where the dish can be purchased
            cell.locationID=item.locationID
            cell.foodImageView.image = item.foodImage
            
            
            //calculate the hours and minutes until closing time
            let totalMinutesUntilClose = item.getClosingTimeAsMinutes() - getCurrentMinutesofDay()
            let hoursUntilClose = totalMinutesUntilClose/60
            let minutesUntilClose = totalMinutesUntilClose%60
            
            //if the dish closes in less than 2 hours, give a countdown
            if(hoursUntilClose >= 1){
                cell.closingTimeLabel.text = "Closing in " + String(hoursUntilClose) + " hours."
            }
                //if the dish closes in more than 2 hours, give the closing time
            else if (hoursUntilClose == 0 && minutesUntilClose > 0){
                cell.closingTimeLabel.text = "Closing in " + String(minutesUntilClose) + " minutes."
            }
            else if (hoursUntilClose < 0 || minutesUntilClose < 0){
                cell.closingTimeLabel.text = "Closed."
            }
            
            
            return cell
            
        }
    
  
    }
    
    func getCurrentMinutesofDay() -> Int {
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        
        return hour*60 + minutes
    }
    
    func tableView(_tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        if indexPath.row == 0{
            return 266
        }
        else{
            return 100
        }
        
    }
    
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            //We have authorization!!
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
