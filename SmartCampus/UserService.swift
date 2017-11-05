//
//  UserService.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 23..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper

struct UserService {
    static func info(_ completion: @escaping (DataResponse<User>) -> Void) {
        let urlString = "String.serverStringstuinfo"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        Alamofire
            .request(urlString, method: .get, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON{ response in
                let response: DataResponse<User> = response.flatMap { json in
                    print("결과")
                    print(response.result)
                    
                    if let user = Mapper<User>().mapArray(JSONArray: json as! [[String : Any]]) {
                        
                        return .success(user[0])
                    } else {
                        let error = MappingError(from: json, to: User.self)
                        return .failure(error)
                    }
                }
                completion(response)
        }
        
    }
    
    static func fetchClassList <T: Class> (_ type: T.Type, success: @escaping (_ success: [Class]) -> (), fail:@escaping(_ error: NSError)->Void)->Void where T:Mappable, T:Meta {
        
        Alamofire.request(type.url())
            .responseArray { (response:
                DataResponse<[T]>) in
                
                switch response.result {
                case .success(let items):
                    print(items)
                    success(items)
                    break;
                //print(items)
                case .failure(let error):
                    fail(error as NSError)
                }
        }
        
    }
    static func fetchTimeSchedule <T: Subject> (_ type: T.Type, success: @escaping (_ success: [Subject]) -> (), fail:@escaping(_ error: NSError)->Void)->Void where T:Mappable, T:Meta {

        Alamofire.request(type.url())
            .responseArray { (response:
                DataResponse<[T]>) in
                
                switch response.result {
                case .success(let items):
                    success(items)
                    break;
                    
                case .failure(let error):
                    fail(error as NSError)
                }
        }
    }
    
    static func fetchAllGrade <T: AllGrade> (_ type: T.Type, success: @escaping (_ success: [AllGrade]) -> (), fail:@escaping(_ error: NSError)->Void)->Void where T:Mappable, T:Meta {
        //모든 성적 가져오기
        Alamofire.request(type.url())
            .responseArray { (response:
                DataResponse<[T]>) in
                
                switch response.result {
                case .success(let items):
                    print(items)
                    success(items)
                    break
                case .failure(let error):
                    fail(error as NSError)
                }
        }
    }
    static func fetchTerm <T: Grade> (_ type: T.Type, success: @escaping (_ success: [Grade]) -> (), fail:@escaping(_ error: NSError)->Void)->Void where T:Mappable, T:Meta {
        //현재까지 들은 학기 정보 가져오기 ex) 2016-1, 2016-2
        Alamofire.request(Network().termURL)
            .responseArray { (response:
                DataResponse<[T]>) in
                
                switch response.result {
                case .success(let items):
                    success(items)
                    break
                case .failure(let error):
                    fail(error as NSError)
                }
        }
    }
    static func fetchGrade <T: Grade> (_ type: T.Type, success: @escaping (_ success: [Grade]) -> (), fail:@escaping(_ error: NSError)->Void)->Void where T:Mappable, T:Meta {
        Alamofire.request(type.url())
            .responseArray { (response:
                DataResponse<[T]>) in
                
                switch response.result {
                case .success(let items):
                    success(items)
                    break
                case .failure(let error):
                    fail(error as NSError)
                }
        }
    }
    static func fetchBefGrade <T:BeforeGrade>(_ type: T.Type, success: @escaping (_ success: [BeforeGrade]) -> (), fail:@escaping(_ error: NSError)->Void)->Void where T:Mappable, T:Meta {
        Alamofire.request(type.url())
            .responseArray { (response:
                DataResponse<[T]>) in
                
                switch response.result {
                case .success(let items):
                    success(items)
                    break
                case .failure(let error):
                    fail(error as NSError)
                }
        }
    }
    static func fetchClassInfo(_ subjectId: String, _ completion: @escaping (DataResponse<ClassInfo>) -> Void) {
        let urlString = "String.serverStringclsinfo?term=1&year=2017&sno=\(subjectId)"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        Alamofire
            .request(urlString, method: .get, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON{ response in
                let response: DataResponse<ClassInfo> = response.flatMap { json in
                    print("결과")
                    print(response.result)
                    
                    if let classInfo = Mapper<ClassInfo>().mapArray(JSONArray: json as! [[String : Any]]) {
                        
                        return .success(classInfo[0])
                    } else {
                        let error = MappingError(from: json, to: User.self)
                        return .failure(error)
                    }
                }
                completion(response)
        }
        
    }
    static func fetchStudentList <T: Student> (_ subjectId:String, _ type: T.Type, success: @escaping (_ success: [Student]) -> (), fail:@escaping(_ error:NSError)->Void)->Void where T: Mappable, T:Meta {
        Alamofire.request("String.serverStringclsmate?term=1&year=2017&sno=\(subjectId)")
            .responseArray { (response:
                DataResponse<[T]>) in
                
                switch response.result {
                case .success(let items):
                    success(items)
                    break;
                    
                case .failure(let error):
                    fail(error as NSError)
                }
        }
    }
}
