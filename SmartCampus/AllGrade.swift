//
//  Subject.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 7..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper
import RealmSwift

class AllGrade: Object, Mappable, Meta {
    dynamic var tot_avg = 0.0 //학점평균
    dynamic var tot_credit = 0 //취득학점
    dynamic var apply_credit = 0 //신청학점
    
    required convenience init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.tot_avg <- map["TOT_AVG"]
        self.tot_credit <- map["TOT_CREDIT"]
        self.apply_credit <- map["APPLY_CREDIT"]
    }
    
    static func url() -> String {
        return Network().allgradeURL
    }
}
