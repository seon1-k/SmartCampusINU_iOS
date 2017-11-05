//
//  Subject.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 7..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Grade: Object, Mappable, Meta {
    // 학점 제이슨
    dynamic var year = ""
    dynamic var term = ""
    dynamic var stu_id = ""
    dynamic var subject_id = ""
    dynamic var subject_name = ""
    dynamic var type = ""
    dynamic var credit = 0
    dynamic var get_rank = ""
    dynamic var score = ""
    dynamic var give_up_yn = ""
    
    dynamic var uuid: String = UUID().uuidString
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
    required convenience init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.year <- map["YEAR"]
        self.term <- map["TERM"]
        self.stu_id <- map["STU_ID"]
        self.subject_id <- map["SUBJECT_ID"]
        self.subject_name <- map["SUBJECT_NAME"]
        self.type <- map["TYPE"]
        self.credit <- map["CREDIT"]
        self.get_rank <- map["GET_RANK"]
        self.score <- map["SCORE"]
        self.give_up_yn <- map["GIVE_UP_YN"]
    }
    
    static func url() -> String {
        return Network().gradeURL
    }
}
