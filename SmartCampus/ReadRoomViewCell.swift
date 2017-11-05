//
//  ReadRoomViewCell.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class ReadRoomViewCell: UITableViewCell {
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var nextButton: UIImageView!
    
    @IBOutlet weak var roomLabelLeading: NSLayoutConstraint!
    @IBOutlet weak var userLabelLeading: NSLayoutConstraint!
    @IBOutlet weak var rateLabelLeading: NSLayoutConstraint!
    @IBOutlet weak var nextButtonTrailing: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if (DeviceUtil.knowScreenWidth() <= 320){
            
            self.roomLabelLeading.constant = 10
            self.userLabelLeading.constant = 90
            self.rateLabelLeading.constant = 170
            self.nextButtonTrailing.constant = 10
            
//            roomCategory.font = UIFont.systemFontOfSize(13)
//            userCount.font = UIFont.systemFontOfSize(13)
//            useRate.font = UIFont.systemFontOfSize(13)
            
        }
        else if (DeviceUtil.knowScreenWidth() > 320 && DeviceUtil.knowScreenWidth() <= 375)
        {
            self.roomLabelLeading.constant = 20
            self.userLabelLeading.constant = 110
            self.rateLabelLeading.constant = 190
            self.nextButtonTrailing.constant = 15
            
//            roomCategory.font = UIFont.systemFontOfSize(16)
//            userCount.font = UIFont.systemFontOfSize(16)
//            useRate.font = UIFont.systemFontOfSize(16)
            
        }
        else if (DeviceUtil.knowScreenWidth() >= 414){
            
            self.roomLabelLeading.constant = 20
            self.userLabelLeading.constant = 130
            self.rateLabelLeading.constant = 220
            self.nextButtonTrailing.constant = 20
            
//            roomCategory.font = UIFont.systemFontOfSize(17)
//            userCount.font = UIFont.systemFontOfSize(17)
//            useRate.font = UIFont.systemFontOfSize(17)
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
