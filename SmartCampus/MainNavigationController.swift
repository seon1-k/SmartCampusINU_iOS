//
//  MainNavigationController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 30..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.keyWindow?.rootViewController = self
        
        // Do any additional setup after loading the view.
    }
    
}
