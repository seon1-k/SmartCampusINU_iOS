//
//  FloatExtension.swift
//  SmartCampus
//
//  Created by SeonIl Kim on 2017. 4. 28..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

extension Float {
    //소수점 반올림
    func roundToPlaces(places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return Darwin.round(self * divisor) / divisor
    }
}
