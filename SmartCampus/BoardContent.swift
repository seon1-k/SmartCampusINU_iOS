//
//  BoardContent.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper

class BoardContent: Mappable {
    
    var id : String?
    var stu_id: String?
    var title: String?
    var content: String?
    var date: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.stu_id <- map["student_no"]
        self.title <- map["title"]
        self.content <- map["content"]
        self.date <- map["date"]
    }
}
