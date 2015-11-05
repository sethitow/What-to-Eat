//
//  ViewController.swift
//  What to Eat
//
//  Created by Seth Itow on 10/10/15.
//  Copyright © 2015 Seth Itow. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    

    var foodItems = [FoodItem]()
    
    override func viewDidLoad() {

        
        super.viewDidLoad()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "enteredForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(FoodItemCell.self, forCellReuseIdentifier: "foodItemCell")
        
        
        FoodItemController.sharedInstance.updateDataWithDummyData()
        foodItems = FoodItemController.sharedInstance.returnNowFoodItems();
        

        
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("FoodItemCell",forIndexPath: indexPath) as! FoodItemCell
            let item = foodItems[indexPath.row]
        
        
        
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

    func getCurrentMinutesofDay() -> Int {
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        
        return hour*60 + minutes
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLocationSegue" {
            
            let indexPath = self.tableView.indexPathForSelectedRow
            
            let cell = tableView.cellForRowAtIndexPath(indexPath!) as! FoodItemCell
            
            let destViewController = segue.destinationViewController as! LocationViewController
            
            destViewController.receivedLocation = cell.locationID
            destViewController.foodItems = foodItems
            
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        
        var index: Int
        for index = 0; index < foodItems.count; ++index{
            
            //commended out to to fatal error
            //let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! FoodItemCell
            //cell.descriptionLabel.sizeToFit() // size the label to fit to top-justify the text
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func enteredForeground(notification: NSNotification) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        tableView.reloadData()
        
    }


}




