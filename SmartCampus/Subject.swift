//
//  Subject.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 7..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Subject: Object, Mappable, Meta {
    // 서버 제이슨
    dynamic var stu_id = ""
    dynamic var id = ""
    dynamic var name = ""
    dynamic var prof = ""
    dynamic var year = ""
    dynamic var term = ""
    dynamic var time = ""
    dynamic var remark = ""
    dynamic var room = ""
    dynamic var day = ""
    dynamic var start_time = ""
    dynamic var end_time = ""
    dynamic var uuid: String = UUID().uuidString
    // 시간표에서 넣는 값
    dynamic var color = ""
    dynamic var isFirstChecked = false
    // 가운데 과목 시간
    dynamic var center_time = ""
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
    required convenience init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.stu_id <- map["STUDENT_STU_ID"]
        self.id <- map["COURSE_ID"]
        self.name <- map["COURSE_NAME"]
        self.prof <- map["COURSE_PROFESSOR"]
        self.year <- map["COURSE_YEAR"]
        self.term <- map["COURSE_TERM"]
        self.time <- map["LECTURE_TIME"]
        self.remark <- map["REMARK"]
        self.room <- map["COURSE_ROOM"]
        self.day <- map["COURSE_DAY"]
        self.start_time <- map["COURSE_DATETIME_START"]
        self.end_time <- map["COURSE_DATETIME_END"]
    }
    
    static func url() -> String {
        return Network().timetableURL
    }
}
