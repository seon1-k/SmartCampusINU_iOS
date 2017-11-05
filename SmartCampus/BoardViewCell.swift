//
//  BoardViewCell.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class BoardViewCell: UICollectionViewCell {
    @IBOutlet weak var boardTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.2
        
        self.backgroundColor = UIColor.white
    
    }
    
}
