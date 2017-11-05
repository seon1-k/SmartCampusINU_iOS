//
//  AuthService.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 23..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import Alamofire

struct AuthService {
    
    static func login(
        userid: String,
        password: String,
        completion: @escaping (_ success: Bool) -> ()) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: URL(string: "\(String.serverString)login?sno=" + userid + "&pw=" + password + "&device=iOS" )!) { (data, response, error) -> Void in
        
            if nil != error {
                
                print("Error : \(error)")
                
                completion(false)
                
            } else {
                
                print(String(data: data!, encoding: String.Encoding.utf8)!)
                OperationQueue.main.addOperation({ () -> Void in
                    
                    if String(data: data!, encoding: String.Encoding.utf8)! == "false" {
                        
                        completion(false)
                        
                    } else {
                        
                        completion(true)
                    }
                })
            }
        }
        task.resume()
        
    }
}
