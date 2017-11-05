//
//  ViewType.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 26..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//
import UIKit

enum viewType: Int {
    case notice, academy, timeschedule, library, restaurant, grade, campusmap, board, appcenter
    
    var viewTitle: String {
        switch self {
        case .notice:
            return "공지사항"
        case .academy:
            return "학사일정"
        case .timeschedule:
            return "시간표"
        case .library:
            return "도서관"
        case .restaurant:
            return "식당"
        case .grade:
            return "학점"
        case .campusmap:
            return "캠퍼스맵"
        case .board:
            return "게시판"
        case .appcenter:
            return "앱센터"
        }
    }
    
}
