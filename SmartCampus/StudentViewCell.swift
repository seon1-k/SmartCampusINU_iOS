//
//  StudentCell.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 28..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class StudentViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.dividerView.isHidden = true
    }

}
