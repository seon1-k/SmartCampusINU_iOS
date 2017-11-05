//
//  Board.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 29..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper

class BoardComment: Mappable, Meta {
    dynamic var stu_id = ""
    dynamic var content = ""
    dynamic var date = ""
    
    required convenience init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.stu_id <- map["student_no"]
        self.content <- map["content"]
        self.date <- map["date"]
    }
    
    //Impl. of Meta protocol
    static func url() -> String {
        return "String.serverStringclist?id="
    }
}
