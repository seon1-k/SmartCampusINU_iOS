//
//  TimeViewCell.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 8..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class TimeViewCell: UICollectionViewCell {

    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
    }

}
