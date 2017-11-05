//
//  AdSize.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 25..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

enum AdSize : CGFloat {
    case ad
    
    
    var viewSize: CGFloat {
        switch DeviceUtil.knowDeviceSize() {
        case 0:
            return 150
        case 1:
            return 200
        case 2:
            return 235
        case 3:
            return 259
        default:
            return 200
        }
    }
    
    
}
