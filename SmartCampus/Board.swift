//
//  Board.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 29..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Board: Object, Mappable, Meta {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var writer = ""
    dynamic var date = ""
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.title <- map["title"]
        self.writer <- map["student_no"]
        self.date <- map["date"]
    }
    
    //Impl. of Meta protocol
    static func url() -> String {
        return "String.serverStringblist"
    }
}
