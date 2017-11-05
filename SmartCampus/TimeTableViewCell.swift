//
//  TimeTableViewCell.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 8..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class TimeTableViewCell: UICollectionViewCell {
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
    }

}
