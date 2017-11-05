//
//  ClassViewCell.swift
//  SmartCampus
//
//  Created by BLU on 2017. 5. 1..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class ClassViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 1.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.2
        
        self.backgroundColor = UIColor.white
    }
    
}
