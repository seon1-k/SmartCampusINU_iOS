//
//  Haksa.swift
//  SmartCampus
//


//struct Haksa {
//    var schedule_id: String
//    var first_date: String
//    var last_date: String
//    var holiday: String
//    var academic_content: String
//
//    
//    init(_ schedule_id: String, _ first_date: String, _ last_date: String, _ holiday: String,_ academic_content: String ) {
//        self.schedule_id = schedule_id
//        self.first_date = first_date
//        self.last_date = last_date
//        self.holiday = holiday
//        self.academic_content = academic_content
//
//    }
//}

import ObjectMapper
import RealmSwift
//int형이면 0
//string 형이면 ""
class Haksa: Object, Mappable, Meta {
    dynamic var schedule_id = 0
    dynamic var first_date = ""
    dynamic var last_date = ""
    dynamic var holiday = 0
    dynamic var academic_content = ""
    
    override static func primaryKey() -> String? {
        return "schedule_id"
    }
    
    required convenience init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.schedule_id <- map["schedule_id"]
        self.first_date <- map["first_date"]
        self.last_date <- map["last_date"]
        self.holiday <- map["holiday"]
        self.academic_content <- map["academic_content"]
    }
    
    static func url() -> String {
        return "String.serverStringschedule.json"
    }
}
