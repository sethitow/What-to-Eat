//
//  ViewController.swift
//  What to Eat
//
//  Created by Seth Itow on 10/10/15.
//  Copyright © 2015 Seth Itow. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView! // IBOutlet for main food tableView
    
    var refreshControl = UIRefreshControl() //pull-to-refresh control for main tableView
    
    override func viewDidLoad() {
        super.viewDidLoad() //call viewDidLoad method
        
        //set up notification fucntion to be called upon enter foregraound
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "enteredForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        //set up the food tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(FoodItemCell.self, forCellReuseIdentifier: "foodItemCell")
        
        //set up refresh control
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView?.addSubview(refreshControl)
        
        //update the data to be loaded into the tableView
        FoodItemController.sharedInstance.updateDataFromWeb()
        FoodItemController.sharedInstance.updateNowFoodItems();
        
    }
 
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FoodItemController.sharedInstance.nowFoodItems.count
    }
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("FoodItemCell",forIndexPath: indexPath) as! FoodItemCell
            let item = FoodItemController.sharedInstance.nowFoodItems[indexPath.row]
        
        
        
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
        if(item.title == "No specials are avalible now"){
            cell.closingTimeLabel.text=""
        }
        else if(hoursUntilClose >= 1){
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
    
    //TODO: make this better
    func getCurrentMinutesofDay() -> Int { //returns the current time of day in minutes since midnight.
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        
        return hour*60 + minutes
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { //called before the next view is loaded
        if segue.identifier == "showLocationSegue" {

            let indexPath = self.tableView.indexPathForSelectedRow //get the indexPath that the user clicked on
            let cell = tableView.cellForRowAtIndexPath(indexPath!) as! FoodItemCell // get the cell at that indexPath
            let destViewController = segue.destinationViewController as! LocationViewController //get the destination view controller
    
            destViewController.receivedLocation = cell.locationID //pass the locationID to the destinationController
            
        }
    }
    
    
    override func viewDidLayoutSubviews() { //called after the view has been layed out, but before it is displayed to the user
        
        var index: Int
        for index = 0; index < FoodItemController.sharedInstance.nowFoodItems.count; ++index{
            
            //top justify description label text
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! FoodItemCell
            cell.descriptionLabel.sizeToFit() // size the label to fit to top-justify the text
            }
        
    }
    
    
    func refresh(sender:AnyObject) { //called when the user pulls-to-refresh
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.LongStyle
        
        FoodItemController.sharedInstance.updateDataFromWeb() //update from the internet
        FoodItemController.sharedInstance.updateNowFoodItems() //filter to currently open foodItems
        
        // update "last updated" title for refresh control
        let updateString = "Last Updated at " + dateFormatter.stringFromDate(FoodItemController.sharedInstance.lastUpdate)
        self.refreshControl.attributedTitle = NSAttributedString(string: updateString)
        
        
        tableView.reloadData() //update the table
        self.refreshControl.endRefreshing()//end the refreshing animation
    }
    
    func enteredForeground(notification: NSNotification) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        if(NSDate().timeIntervalSinceDate(FoodItemController.sharedInstance.lastUpdate) > 300){ // if last update was longer than 5 mins ago
        FoodItemController.sharedInstance.updateDataFromWeb() // reupdate with web data
        }
        
        FoodItemController.sharedInstance.updateNowFoodItems()
        tableView.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




