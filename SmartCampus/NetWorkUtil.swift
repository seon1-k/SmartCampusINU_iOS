//
//  NetWorkUtil.swift
//  SmartCampus
//
//  Created by BLU on 2017. 5. 2..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import SystemConfiguration

class NetWorkUtil: NSObject {
    
    // 인터넷 연결 확인
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    // 앱 업데이트 여부 확인
    static func needUpdate() -> Bool {
        
        let ret = NSMutableDictionary()
        
        let infoDic = Bundle.main.infoDictionary
        let appID = infoDic!["CFBundleIdentifier"] as! String
        let jsonData = getJSON(urlToRequest: "http://itunes.apple.com/lookup?bundleId="+appID)
        let lookup = try? JSONSerialization.jsonObject(with: jsonData as Data, options:  JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        
        //
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        ret.setValue(appVersion, forKey: "appVersion")
        ret.setValue(false, forKey: "needUpdate")
        
        //
        if ( (lookup!["resultCount"] as AnyObject).integerValue == 1 ) {
            let resultsArray = lookup!["results"] as! NSArray // MDLMaterialProperty to Array
            let resultsDic = resultsArray[0] as! NSDictionary
            let storeVersion = resultsDic["version"] as! String
            if (storeVersion as NSString).compare(appVersion, options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending {
                ret.setValue(true, forKey: "needUpdate")
            }
            ret.setValue(storeVersion, forKey: "storeVersion")
        }
        
        //결과에 따라 앱스토어 링크 연결할지 확인
        //https://itunes.apple.com/us/app/smartcampusinu/id1123199010?mt=8
        print(ret)
        if let isNeedUpdate = ret.value(forKeyPath: "needUpdate") {
            return isNeedUpdate as! Bool
        }
        else {
            return false
        }
    }
    
    static func getJSON(urlToRequest: String) -> NSData {
        var data = NSData()
        do {
            data = try NSData(contentsOf: NSURL(string: urlToRequest)! as URL, options: NSData.ReadingOptions() )
        } catch let error as NSError {
            print( error.description )
        } catch {}
        return data
        
    }
    
}
