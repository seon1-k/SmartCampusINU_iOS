//
//  MainButtonSize.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 23..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

enum MainButtonSize {
    // 아이폰 6s plus && 7
    case button
    
    var cellSize: CGSize {
        switch DeviceUtil.knowDeviceSize() {
        case 0:
            return CGSize(width:76, height:76)
        case 1:
            return CGSize(width:95, height:95)
        case 2:
            return CGSize(width:95, height:95)
        case 3:
            return CGSize(width:108, height:108)
        default:
            return CGSize(width:90, height:90)
        }
    }
    
    
    
    
}
