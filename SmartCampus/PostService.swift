//
//  PostService.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import Alamofire
import ObjectMapper

class PostService: NSObject {
    
    static func writeBoard(stuid: String, title: String, date:String, content:String , completion: @escaping (DataResponse<Void>) -> Void) {
        let urlString = "String.serverStringbwrite"
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters: Parameters = [
            "student_no":"\(stuid)",
            "title":"\(title)",
            "date":"\(date)",
            "content": "\(content)"
        ]
        
        Alamofire.request(urlString, method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseData { response in
                let response: DataResponse<Void> = response.flatMap { _ in
                    return .success(Void())
                }
                completion(response)
        }
    }
    static func writeComment(stuid: String, b_id: Int, date:String, content:String , completion: @escaping (DataResponse<Void>) -> Void) {
        let urlString = "String.serverStringcwrite"
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters: Parameters = [
            "student_no":stuid,
            "id":b_id,
            "date":date,
            "content": content
        ]
        
        Alamofire.request(urlString, method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseData { response in
                let response: DataResponse<Void> = response.flatMap { _ in
                    return .success(Void())
                }
                completion(response)
        }
    }
    static func logout(completion: @escaping (DataResponse<Void>) -> Void) {
        let urlString = "String.serverStringlogout"
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(urlString, method: .post, parameters: nil, headers: headers)
            .validate(statusCode: 200..<400)
            .responseData { response in
                let response: DataResponse<Void> = response.flatMap { _ in
                    return .success(Void())
                }
                completion(response)
        }
    }
}
