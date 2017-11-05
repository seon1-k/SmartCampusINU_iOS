//
//  ReadingRoom.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 28..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

struct ReadingRoom {
    var room: String
    var user: String
    var rate: String
    var link: String
    
    init(room: String, user: String, rate: String, link: String) {
        self.room = room
        self.user = user
        self.rate = rate
        self.link = link
    }
}
