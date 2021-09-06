//
//  RestaurantTableViewCell.swift
//  UberEatsLike
//
//  Created by user on 2021/09/05.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeRequiredLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setCell(restaurant: Restaurant){
        self.titleLabel.text = restaurant.name as String
        self.timeRequiredLabel.text = restaurant.timeRequired as? String
        self.feeLabel.text = restaurant.fee as? String
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
