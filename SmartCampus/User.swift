//
//  User.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 17..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper

class User: Mappable {
    
    var id: String?
    var username: String?
    var department: String?
    var major: String?
    var college: String?
    var status: String?
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        self.id <- map["STUDENT_NO"]
        self.username <- map["NAME"]
        self.department <- map["DEPARTMENT"]
        self.major <- map["MAJOR"]
        self.college <- map["MAIN_DIV"]
        self.status <- map["STU_STAT"]
    }
}
