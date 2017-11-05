//
//  GradeBottomPointCell.swift
//  SmartCampus
//
//  Created by SeonIl Kim on 2017. 4. 28..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class GradeBottomPointCell: UICollectionViewCell {
    let nameL:UILabel = {
        let ul = UILabel(frame: .zero)
        ul.textColor = UIColor(red: 109, green: 111, blue: 113)
        ul.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 11)
        ul.textAlignment = .center
        ul.backgroundColor = .white
        ul.numberOfLines = 0
        ul.lineBreakMode = .byWordWrapping
        return ul
    }()
    
    let typeL:UILabel = {
        let ul = UILabel(frame: .zero)
        ul.textColor = UIColor(red: 109, green: 111, blue: 113)
        ul.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        ul.textAlignment = .center
        ul.backgroundColor = .white
        return ul
    }()
    
    let creditL:UILabel = {
        let ul = UILabel(frame: .zero)
        ul.textColor = UIColor(red: 109, green: 111, blue: 113)
        ul.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        ul.textAlignment = .center
        ul.backgroundColor = .white
        return ul
    }()
    
    let rankL:UILabel = {
        let ul = UILabel(frame: .zero)
        ul.textColor = UIColor(red: 204, green: 51, blue: 51)
        ul.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        ul.textAlignment = .center
        ul.backgroundColor = .white
        return ul
    }()
    
    let scoreL:UILabel = {
        let ul = UILabel(frame: .zero)
        ul.textColor = UIColor(red: 160, green: 206, blue: 98)
        ul.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        ul.textAlignment = .center
        ul.backgroundColor = .white
        return ul
    }()
    
    let bottomLine: UIView = {
        let uv = UIView(frame: .zero)
        uv.backgroundColor = UIColor(red: 229, green: 229, blue: 229)
        return uv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 229, green: 229, blue: 229)
        
        addSubview(nameL)
        addConstraintsWithFormat(format: "H:[v0(\((frame.width-4) / 6 * 2))]", views: nameL)
        addConstraintsWithFormat(format: "V:[v0(39)]", views: nameL)
        addConstraint(NSLayoutConstraint(item: nameL, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        
        addSubview(typeL)
        addConstraintsWithFormat(format: "H:[v0(\((frame.width-4) / 6 * 1))]", views: typeL)
        addConstraintsWithFormat(format: "V:[v0(39)]", views: typeL)
        addConstraint(NSLayoutConstraint(item: typeL, attribute: .leading, relatedBy: .equal, toItem: nameL, attribute: .trailing, multiplier: 1, constant: 1))
        
        addSubview(creditL)
        addConstraintsWithFormat(format: "H:[v0(\((frame.width-4) / 6 * 1))]", views: creditL)
        addConstraintsWithFormat(format: "V:[v0(39)]", views: creditL)
        addConstraint(NSLayoutConstraint(item: creditL, attribute: .leading, relatedBy: .equal, toItem: typeL, attribute: .trailing, multiplier: 1, constant: 1))
        
        addSubview(rankL)
        addConstraintsWithFormat(format: "H:[v0(\((frame.width-4) / 6 * 1))]", views: rankL)
        addConstraintsWithFormat(format: "V:[v0(39)]", views: rankL)
        addConstraint(NSLayoutConstraint(item: rankL, attribute: .leading, relatedBy: .equal, toItem: creditL, attribute: .trailing, multiplier: 1, constant: 1))
        
        addSubview(scoreL)
        addConstraintsWithFormat(format: "H:[v0(\((frame.width-4) / 6 * 1))]", views: scoreL)
        addConstraintsWithFormat(format: "V:[v0(39)]", views: scoreL)
        addConstraint(NSLayoutConstraint(item: scoreL, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        
        
        
        addSubview(bottomLine)
        bottomLine.frame.size.width = frame.width
        bottomLine.frame.size.height = 1
        bottomLine.frame.origin.y = frame.height - bottomLine.frame.height
        
        //2 1 1 1 1
        //        backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
