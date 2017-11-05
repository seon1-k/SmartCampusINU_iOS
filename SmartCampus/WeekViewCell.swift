//
//  WeekViewCell.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 8..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class WeekViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

}
