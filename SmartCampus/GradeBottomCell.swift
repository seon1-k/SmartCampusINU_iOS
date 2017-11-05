//
//  GradeBottomCell.swift
//  SmartCampus
//
//  Created by SeonIl Kim on 2017. 4. 28..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class GradeBottomCell: UICollectionViewCell {
    let titleL:UILabel = {
        let ul = UILabel(frame: .zero)
        ul.textColor = UIColor(red: 109, green: 111, blue: 113)
        ul.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
        ul.textAlignment = .center
        ul.backgroundColor = .white
        return ul
    }()
    
    let typeL:UILabel = {
        let ul = UILabel(frame: .zero)
        ul.textColor = UIColor(red: 109, green: 111, blue: 113)
        ul.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        ul.textAlignment = .center
        ul.backgroundColor = .white
        return ul
    }()
    
    let avgL:UILabel = {
        let ul = UILabel(frame: .zero)
        ul.textColor = UIColor(red: 109, green: 111, blue: 113)
        ul.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
        ul.textAlignment = .center
        ul.backgroundColor = .white
        return ul
    }()
    
    let pointL:UILabel = {
        let ul = UILabel(frame: .zero)
        ul.textColor = UIColor(red: 109, green: 111, blue: 113)
        ul.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        ul.textAlignment = .center
        ul.backgroundColor = .white
        return ul
    }()
    
    let bottomLine: UIView = {
        let uv = UIView(frame: .zero)
        uv.backgroundColor = UIColor(red: 229, green: 229, blue: 229)
        return uv
    }()
    
    //229
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 229, green: 229, blue: 229)
        
        addSubview(titleL)
        titleL.text = "전체학점"
        addConstraintsWithFormat(format: "H:[v0(\((frame.width-3) / 5 * 2))]", views: titleL)
        addConstraintsWithFormat(format: "V:[v0(39)]", views: titleL)
        addConstraint(NSLayoutConstraint(item: titleL, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        
        addSubview(typeL)
        typeL.text = "취득학점"
        addConstraintsWithFormat(format: "H:[v0(\((frame.width-3) / 5 * 1))]", views: typeL)
        addConstraintsWithFormat(format: "V:[v0(39)]", views: typeL)
        addConstraint(NSLayoutConstraint(item: typeL, attribute: .leading, relatedBy: .equal, toItem: titleL, attribute: .trailing, multiplier: 1, constant: 1))
        
        addSubview(pointL)
        pointL.text = ""
        addConstraintsWithFormat(format: "H:[v0(\((frame.width-3) / 5 * 1))]", views: pointL)
        addConstraintsWithFormat(format: "V:[v0(39)]", views: pointL)
        addConstraint(NSLayoutConstraint(item: pointL, attribute: .leading, relatedBy: .equal, toItem: typeL, attribute: .trailing, multiplier: 1, constant: 1))
        
        addSubview(avgL)
        avgL.text = ""
        addConstraintsWithFormat(format: "H:[v0(\((frame.width-3) / 5 * 1))]", views: avgL)
        addConstraintsWithFormat(format: "V:[v0(39)]", views: avgL)
        addConstraint(NSLayoutConstraint(item: avgL, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        
        addSubview(bottomLine)
        bottomLine.frame.size.width = frame.width
        bottomLine.frame.size.height = 1
        bottomLine.frame.origin.y = frame.height - bottomLine.frame.height
        
        //2:1:1:1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
