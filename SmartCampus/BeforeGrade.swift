//
//  BeforeGrade.swift
//  SmartCampus
//
//  Created by SeonIl Kim on 2017. 4. 29..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import ObjectMapper
import RealmSwift

class BeforeGrade: Object, Mappable, Meta {
    
    //            'select year,student_no,subject_nm,isu_div,credit,score,get_rank,bigo,grade_type from v_campus_05 where student_no = :sno';
//    beforeGradeItem beforeGradeItem = new beforeGradeItem(
    //object.getString("SUBJECT_NM") 과목명
    //, object.getString("ISU_DIV"), 종류 /전필 전선 교선 등
    //object.getString("CREDIT") 학점 포인트( 2, 3)
    //, object.getString("GET_RANK"), 학점 영문  A A+
//    object.getString("BIGO")); 학점 -> 숫자. 4.0 3.5 등등
    
    dynamic var subject_name = "" // 과목명
    dynamic var isu_div = "" // 전공필수, 전공선택, 교양선택 등
    dynamic var credit = "" // 몇 학점인지, 2, 3학점
    dynamic var get_rank = "" // 학점 영문. A+, A, B+ 등
    dynamic var bigo = "" // 학점 숫자. 4.0, 3.5 등
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.subject_name <- map["SUBJECT_NAME"]
        self.isu_div <- map["ISU_DIV"]
        self.credit <- map["CREDIT"]
        self.get_rank <- map["GET_RANK"]
        self.bigo <- map["BIGO"]
    }
    
    static func url() -> String {
        return Network().beforegradeURL
    }
}
