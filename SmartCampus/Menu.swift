//
//  Menu.swift
//  SmartCampus
//
//  Created by SeonIl Kim on 2017. 4. 10..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

struct Menu {
    var name: String
    var corner: String
    var menu_num: Int
    var menu: String
    
    init(_ name: String, _ corner: String, _ menu_num: Int, _ menu: String) {
        self.name = name
        self.corner = corner
        self.menu_num = menu_num
        self.menu = menu
    }
}

//struct Menu: Mappable {
//    var name: String = ""
//    var corner: String = ""
//    var menu_num: Int = -1
//    var menu: String = ""
//    
//    init?(map: Map) {  }
//    
//    mutating func mapping(map: Map) {
//        name <- map["name"]
//        corner <- map["corner"]
//        menu_num <- map["menu_num"]
//        menu <- map["menu"]
//    }
//}

//struct Notice {
//    var title: String
//    var writer: String
//    var date: String
//    var link: String
//    
//    init(_ title: String, _ writer: String, _ date: String, _ link: String) {
//        self.title = title
//        self.writer = writer
//        self.date = date
//        self.link = link
//        
//    }
//}
