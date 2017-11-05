//
//  MenuViewCell.swift
//  SmartCampus
//
//  Created by SeonIl Kim on 2017. 4. 12..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class MenuViewCell: UICollectionViewCell {
    
    let menuLabel: UILabel = {
        let ul = UILabel(frame: .zero)
        ul.translatesAutoresizingMaskIntoConstraints = false
        ul.numberOfLines = 0
        ul.lineBreakMode = .byWordWrapping
        ul.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        return ul
    }()
    
    let cornerLabel: UILabel = {
        let ul = UILabel(frame: .zero)
        ul.translatesAutoresizingMaskIntoConstraints = false
        ul.numberOfLines = 0
        ul.lineBreakMode = .byWordWrapping
        ul.textAlignment = .center
        ul.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        return ul
    }()
    
    //    var authorLabel: UILabel?
    //    var dateLabel: UILabel?
    //    var rightArrow: UIImageView?
    
    let underLine: UIView = {
        let uv = UIView(frame: .zero)
        uv.backgroundColor = .gray
        return uv
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        
        layer.backgroundColor = UIColor.white.cgColor
        addConstraintsWithFormat(format: "H:[v0(\(DeviceUtil.knowScreenWidth()))]", views: self)
        
        let corner_width = Int(DeviceUtil.knowScreenWidth() / 4)
        addSubview(cornerLabel)
        addConstraintsWithFormat(format: "H:[v0(\(corner_width))]", views: cornerLabel)
        //        addConstraintsWithFormat(format: "V:|[v0]|", views: cornerLabel)
        addConstraint(NSLayoutConstraint(item: cornerLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        //        addConstraint(NSLayoutConstraint(item: cornerLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: cornerLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        let menu_width = Int(DeviceUtil.knowScreenWidth() / 4 * 3)
        addSubview(menuLabel)
        addConstraintsWithFormat(format: "H:[v0(\(menu_width))]", views: menuLabel)
        //        addConstraintsWithFormat(format: "V:|[v0]|", views: menuLabel)
        addConstraint(NSLayoutConstraint(item: menuLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        //        addConstraint(NSLayoutConstraint(item: menuLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: menuLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addSubview(underLine)
        addConstraintsWithFormat(format: "H:|[v0]|", views: underLine)
        addConstraintsWithFormat(format: "V:[v0(0.5)]", views: underLine)
        addConstraint(NSLayoutConstraint(item: underLine, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
}

class MenuSectionView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let ul = UILabel(frame: .zero)
        ul.translatesAutoresizingMaskIntoConstraints = false
        ul.textColor = .white
        ul.font = UIFont(name: "AppleSDGothicNeo-Bold", size: ul.font.pointSize)
        return ul
    }()
    
    let timeLabel: UILabel = {
        let ul = UILabel(frame: .zero)
        ul.translatesAutoresizingMaskIntoConstraints = false
        ul.textColor = .white
        ul.numberOfLines = 0
        ul.lineBreakMode = .byWordWrapping
        ul.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 8)
        return ul
    }()
    
    let timeLabel2: UILabel = {
        let ul = UILabel(frame: .zero)
        ul.translatesAutoresizingMaskIntoConstraints = false
        ul.textColor = .white
        ul.numberOfLines = 0
        ul.lineBreakMode = .byWordWrapping
        ul.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 8)
        return ul
    }()
    
    let underLine: UIView = {
        let uv = UIView(frame: .zero)
        uv.backgroundColor = .gray
        return uv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        addSubview(titleLabel)
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15))
        
        addSubview(timeLabel)
        addConstraint(NSLayoutConstraint(item: timeLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: timeLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15))
        
        addSubview(timeLabel2)
        addConstraint(NSLayoutConstraint(item: timeLabel2, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: timeLabel2, attribute: .trailing, relatedBy: .equal, toItem: timeLabel, attribute: .leading, multiplier: 1, constant: -15))
        
        backgroundColor = UIColor(red: 138/255, green: 194/255, blue: 65/255, alpha: 1)
        
        addSubview(underLine)
        addConstraintsWithFormat(format: "H:|[v0]|", views: underLine)
        addConstraintsWithFormat(format: "V:[v0(0.5)]", views: underLine)
        addConstraint(NSLayoutConstraint(item: underLine, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
}
