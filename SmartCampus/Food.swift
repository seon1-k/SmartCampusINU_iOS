//
//  Food.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

struct Food {
    let name: String
    let flickrID: String
    var image: UIImage?
    
    init(name: String, flickrID: String) {
        self.name = name
        self.flickrID = flickrID
        image = UIImage(named:"2-profile")
    }
}

extension Food: CustomStringConvertible {
    var description: String {
        return "\(name): flickr.com/\(flickrID)"
    }
}
