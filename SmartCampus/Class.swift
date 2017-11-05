//
//  Class.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 6..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Class: Object, Mappable, Meta {
    dynamic var subjectid = ""
    dynamic var subjectname = ""
    
    override static func primaryKey() -> String? {
        return "subjectid"
    }
    
    required convenience init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.subjectid <- map["SUBJECT_NO"]
        self.subjectname <- map["SUBJECT_NM"]
    }
    
    static func url() -> String {
        return "String.serverStringclslist?term=1&year=2017"
    }
}
