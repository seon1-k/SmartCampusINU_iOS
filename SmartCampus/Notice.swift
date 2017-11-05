//
//  Notice.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

struct Notice {
    var title: String
    var writer: String
    var date: String
    var link: String
    
    init(_ title: String, _ writer: String, _ date: String, _ link: String) {
        self.title = title
        self.writer = writer
        self.date = date
        self.link = link
        
    }
}
