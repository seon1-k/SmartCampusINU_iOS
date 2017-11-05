//
//  Map.swift
//  SmartCampus
//
//  Created by SeonIl Kim on 2017. 4. 29..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper
import RealmSwift

class MapData: Object, Mappable, Meta {
    // 학점 제이슨
    dynamic var name = ""
    dynamic var longti = 0.0
    dynamic var lati = 0.0
    
    required convenience init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        self.name <- map["name"]
        self.longti <- map["longti"]
        self.lati <- map["lati"]
    }
    
    static func url() -> String {
        return Network().mapURL
    }
}

class MD {
    //검색을 위한 object
    var name:String!
    var longti:Double!
    var lati:Double!
    var index:Int!
    
    init(_ name:String, _ longti:Double, _ lati:Double, _ index:Int) {
        self.name = name
        self.longti = longti
        self.lati = lati
        self.index = index
    }
}

//class Haksa: Object, Mappable, Meta {
//    dynamic var schedule_id = 0
//    dynamic var first_date = ""
//    dynamic var last_date = ""
//    dynamic var holiday = 0
//    dynamic var academic_content = ""
//    
//    override static func primaryKey() -> String? {
//        return "schedule_id"
//    }
//    
//    required convenience init(map: Map) {
//        self.init()
//    }
//    
//    func mapping(map: Map) {
//        self.schedule_id <- map["schedule_id"]
//        self.first_date <- map["first_date"]
//        self.last_date <- map["last_date"]
//        self.holiday <- map["holiday"]
//        self.academic_content <- map["academic_content"]
//    }
//    
//    static func url() -> String {
//        return "String.serverStringschedule.json"
//    }
//}
//class MapData {
//    var name:String
//    var longti:Double
//    var lati:Double
//    
//    init(_ name:String, _ longti:Double, _ lati:Double) {
//        self.name = name
//        self.longti = longti
//        self.lati = lati
//    }
//}
