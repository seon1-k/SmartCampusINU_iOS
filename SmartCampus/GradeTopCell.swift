//
//  GradeTopCell.swift
//  SmartCampus
//
//  Created by SeonIl Kim on 2017. 4. 28..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class GradeTopCell: UICollectionViewCell {
    let titleL:UILabel = {
        let ul = UILabel(frame: .zero)
        ul.textColor = .white
        ul.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        ul.textAlignment = .center
        return ul
    }()
    
    let dataL:UILabel = {
        let ul = UILabel(frame: .zero)
        ul.textColor = .white
        ul.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        ul.textAlignment = .center
        return ul
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleL)
        addConstraintsWithFormat(format: "H:|[v0]|", views: titleL)
        addConstraintsWithFormat(format: "V:[v0(22)]", views: titleL)
        addConstraint(NSLayoutConstraint(item: titleL, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 3))
        
        addSubview(dataL)
        addConstraintsWithFormat(format: "H:|[v0]|", views: dataL)
        addConstraintsWithFormat(format: "V:[v0(25)]", views: dataL)
        addConstraint(NSLayoutConstraint(item: dataL, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
