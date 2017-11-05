//
//  Student.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 29..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper

class Student: Mappable, Meta {
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var division = ""
    dynamic var department = ""
    dynamic var major = ""
    
    required convenience init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["STU_ID"]
        self.name <- map["NAME"]
        self.division <- map["MAIN_DIV"]
        self.department <- map["DEPARTMENT"]
        self.major <- map["MAJOR"]
    }
    
    //Impl. of Meta protocol
    static func url() -> String {
        return "String.serverStringclsinfo?"
    }
}
