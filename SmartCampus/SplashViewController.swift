//
//  SplashViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 30..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    var timer = Timer()
    let userDefaults = Foundation.UserDefaults.standard
    let queue = DispatchQueue.global()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
            
            
            if gsno(self.userDefaults.string(forKey: "autoLogin")) == "1" {
                
                AuthService.login(
                    userid: gsno(self.userDefaults.string(forKey: "stuid")),
                    password: gsno(self.userDefaults.string(forKey: "stupw"))
                ) {  (success) -> () in
                    switch (success) {
                    case true: print("성공했다")
                    
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainnavcontroller")
                    
                    self.present(vc, animated: true, completion: nil)
                        
                    case false: print("실패했다")
                        
                    }
                    
                }
                
            } else {
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginviewcontroller")
                self.present(vc, animated: false, completion: nil)
                
            }
            
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
