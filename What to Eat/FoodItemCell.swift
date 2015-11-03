//
//  FoodItemCell.swift
//  What to Eat
//
//  Created by Seth Itow on 10/10/15.
//  Copyright © 2015 Seth Itow. All rights reserved.
//

import UIKit

class FoodItemCell: UITableViewCell {
    
    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var closingTimeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    var locationID:String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
