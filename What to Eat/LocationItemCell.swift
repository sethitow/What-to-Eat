//
//  LocationItemCell.swift
//  What to Eat
//
//  Created by Seth Itow on 10/11/15.
//  Copyright © 2015 Seth Itow. All rights reserved.
//

import UIKit
import MapKit

class LocationItemCell: UITableViewCell {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var locationTitle: UILabel!
    @IBOutlet var locationDescription: UILabel!
    
   
    @IBOutlet var breakfastHoursString: UILabel!
    @IBOutlet var lunchHoursString: UILabel!
    @IBOutlet var dinnerHoursString: UILabel!
    
    @IBOutlet var locationLine1: UILabel!
    @IBOutlet var locationLine2: UILabel!
    @IBOutlet var locationLine3: UILabel!
    
  

    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
