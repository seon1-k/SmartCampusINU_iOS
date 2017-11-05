//
//  GetService.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import AEXML
import Kanna
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol Meta {
    static func url() -> String
}

struct GetService {
    static let googleMapKey = "AIzaSyCTx5BPejs4JefGi3URr46hCudWwNc1bSU"
    
    static func fetchHaksa <T: Haksa> (_ type: T.Type, success: @escaping (_ success: [Haksa]) -> (), fail:@escaping(_ error: NSError)->Void)->Void where T:Mappable, T:Meta {
        
        Alamofire.request(type.url())
            .responseArray { (response:
                DataResponse<[T]>) in
                
                switch response.result {
               
                case .success(let items):
//                    print(items)
                        success(items)
                    
                    break;
                //print(items)
                case .failure(let error):
                    fail(error as NSError)
                }
        }
        
    }
    
    static func fetchMenu(
        requesturl: String,
        name: String,
        completion: @escaping (_ success: [Menu]) -> ()) {
        
        var menus = [Menu]()
        
        let today = Date()
//        print(today)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let params : [String:Any] = [
            "page" : 0,
            "date" : formatter.string(from: today),
            "name" : name
        ]
        
        
        
        Alamofire.request(requesturl, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(_):
                if let json = response.result.value as? NSArray {
//                    print(json)
                    for item in json {
                        let temp = item as? [String:Any]
                        let name = gsno(temp!["name"] as? String)
                        let corner = gsno(temp!["corner"] as? String)
                        let menu_num = temp!["menu_num"] as? Int
                        let menu = gsno(temp!["menu"] as? String)
                        if menu != "" {
                            let result = Menu(name, corner, menu_num!, menu)
                            menus.append(result)
                        }
                    }
                }
                if menus.count == 0 {
                    menus.append(Menu(name, "", 0, "오늘은 쉽니다"))
                }
                completion(menus)
                break
            case .failure(let error):
                print(error)
                completion(menus)
                break
            }
        }
    }
    
    static func fetchNotices(
        requesturl: String,
        boardid: String,
        completion: @escaping (_ success: [Notice]) -> ()) {
        var notices = [Notice]()
        
        defer {
            
        }
        
        guard let data = try? Data(contentsOf: URL(string: requesturl + boardid)!)
            else { print("nono"); return}
        do {
            let document = try AEXMLDocument(xml: data)
            print("출력")
            
            let arrayCount = document.root["channel"]["item"].count - 1
            
            for index in 0...arrayCount {
                print(index)
                
                let title = document.root["channel"].children[4+index].children[0].string
                let writer = document.root["channel"].children[4+index].children[1].string
                
                let str : String = document.root["channel"].children[4+index].children[2].string
                let replacedStr = str.replacingOccurrences(of:"http://www.incheon.ac.kr/cop/mypage/myBoardView.do?", with: "http://www.incheon.ac.kr/user/boardList.do?command=view&boardId=" + boardid + "&")
                print(replacedStr)
                let link = replacedStr
                let date = document.root["channel"].children[4+index].children[3].string.trimmingCharacters(in: (NSCharacterSet(charactersIn: "00:00:00 +0900")) as CharacterSet)
                
                let notice = Notice(title, writer, date, link)
                print(notice.date)
                print(notice.title)
                print(notice.link)
                print(notice.writer)
                notices.append(notice)
                
                //http://www.kuma-de.com/blog/2015-09-14/6966
            }
            
        } catch {
            
        }
        completion(notices)
    }
    
    static func fetchReadingRoom(
        requesturl: String,
        completion: @escaping (_ success: [ReadingRoom]) -> ()) {
        var readingRooms = [ReadingRoom]()
        
        //////
        for index in 1...4 {
            if let doc = Kanna.HTML(url: (URL(string: "\(String.libString)SeatMate.php?classInfo=" + String(index))!), encoding: String.Encoding.nextstep) { for link in doc.xpath("body/table/tr/td/table[2]/tr/td[2]/table/tr/td[5]") {
                
                var html = link.text
                html = html!.replacingOccurrences(of: " ", with: "")
                
                var room : String!
                var useRate : String!
                var user : String!
                var link : String!
                
                switch index {
                case 1:
                    room = "자유열람실1"
                    user = html! + "/240"
                    useRate = String(Int((Float(html!)! / 240) * 100)) + "%"
                    link = "\(String.libString)SeatMate.php?classInfo=1"
                    break;
                case 2:
                    room = "자유열람실2"
                    user = html! + "/394"
                    useRate = String(Int((Float(html!)! / 394) * 100)) + "%"
                    link = "\(String.libString)SeatMate.php?classInfo=2"
                    break;
                case 3:
                    room = "자유열람실3"
                    user = html! + "/240"
                    useRate = String(Int((Float(html!)! / 240) * 100)) + "%"
                    link = "\(String.libString)SeatMate.php?classInfo=3"
                    break;
                case 4:
                    room = "노트북코너"
                    user = html! + "/108"
                    useRate = String(Int((Float(html!)! / 108) * 100)) + "%"
                    link = "\(String.libString)SeatMate.php?classInfo=4"
                    break;
                default:
                    break;
                }
                
                let readingRoom = ReadingRoom(room: room, user: user, rate: useRate, link: link)
                readingRooms.append(readingRoom)
                //
                }
            }
            
            completion(readingRooms)
            //////
        }
}
    
    //
    static func fetchBoardList <T: Board> (_ type: T.Type, success: @escaping (_ success: [Board]) -> (), fail:@escaping(_ error:NSError)->Void)->Void where T: Mappable, T:Meta {
        Alamofire.request(type.url())
            .responseArray { (response:
                DataResponse<[T]>) in
                
                switch response.result {
                case .success(let items):
                    success(items)
                    break;
                    //print(items)
                case .failure(let error):
                    fail(error as NSError)
                    }
                }
    }
    
    static func fetchBoardContent(_ boardId: Int, _ completion: @escaping (DataResponse<BoardContent>) -> Void) {
        let urlString = "String.serverStringbread?id=\(boardId)"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        Alamofire
            .request(urlString, method: .get, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON{ response in
                let response: DataResponse<BoardContent> = response.flatMap { json in
                    print("결과")
                    print(response.result)
                    
                    if let boardContent = Mapper<BoardContent>().mapArray(JSONArray: json as! [[String : Any]]) {
                        
                        return .success(boardContent[0])
                    } else {
                        let error = MappingError(from: json, to: BoardContent.self)
                        return .failure(error)
                    }
                }
                completion(response)
        }
        
    }
    
    static func fetchCommentList <T: BoardComment> (_ boardId:Int, _ type: T.Type, success: @escaping (_ success: [BoardComment]) -> (), fail:@escaping(_ error:NSError)->Void)->Void where T: Mappable, T:Meta {
        Alamofire.request("String.serverStringclist?id=" + String(boardId))
            .responseArray { (response:
                DataResponse<[T]>) in
                
                switch response.result {
                case .success(let items):
                    success(items)
                    break;
                //print(items)
                case .failure(let error):
                    fail(error as NSError)
                }
        }
    }

    
    static func fetchMapData <T: MapData> (_ type: T.Type, success: @escaping (_ success: [MapData]) -> (), fail:@escaping(_ error: NSError)->Void)->Void where T:Mappable, T:Meta {
        
        Alamofire.request(type.url())
            .responseArray { (response:
                DataResponse<[T]>) in
                
                switch response.result {
                    
                case .success(let items):
//                    print(items)
                    success(items)
                    break;
                case .failure(let error):
                    fail(error as NSError)
                }
        }
    }
    
    static func getAdUri(_ completion: @escaping ([String]) -> Void) {
        Alamofire.request(Network().adUriURL, encoding: JSONEncoding.default).responseJSON { res in
            var returnvalue:[String] = []
            
            let result = res.result.value as! [[String:Any]]
            let urls = result[0]
            returnvalue.append(gsno(urls["ad1"] as? String))
            returnvalue.append(gsno(urls["ad2"] as? String))
            returnvalue.append(gsno(urls["ad3"] as? String))
            returnvalue.append(gsno(urls["ad4"] as? String))
            returnvalue.append(gsno(urls["ad5"] as? String))
            completion(returnvalue)
        }
    }
}

