//
//  DateUtil.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 28..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class DateUtil: NSObject {
    
    static func convertDateString(dateString : String!, fromFormat sourceFormat : String!, toFormat desFormat : String!) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceFormat
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = desFormat
        
        return dateFormatter.string(from: date!)
    }
    static func getCurrentTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        
        let result = formatter.string(from: date)
        print(result)
        return result
    }
}
