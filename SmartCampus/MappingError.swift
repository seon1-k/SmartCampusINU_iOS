//
//  MappingError.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 24..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

struct MappingError: Error, CustomStringConvertible {
    
    let description: String
    
    init(from: Any?, to: Any.Type) {
        self.description = "Failed to map \(from) to \(to)"
    }
    
}
