//
//  ClassInfo.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 29..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper

class ClassInfo: Mappable, Meta {
    dynamic var course_name = ""
    dynamic var room = ""
    dynamic var prof = ""
    dynamic var textbook = ""
    dynamic var goal = ""
    dynamic var day = ""
    
    required convenience init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.course_name <- map["COURSE_NAME"]
        self.room <- map["ROOM_NO"]
        self.prof <- map["PROF_NM"]
        self.textbook <- map["M_MASTER_NM"]
        self.goal <- map["SUBJECT_GOAL"]
        self.day <- map["DAY"]
    }
    
    //Impl. of Meta protocol
    static func url() -> String {
        return "String.serverStringclsinfo?"
    }
}
