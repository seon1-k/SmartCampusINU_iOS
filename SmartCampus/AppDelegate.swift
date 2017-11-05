//
//  AppDelegate.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 17..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var timeCount = 0
    var timer: Timer!
    let queue = DispatchQueue(label: "Timer DispatchQueue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    let userDefaults = Foundation.UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        configureAppearance()
        GMSServices.provideAPIKey(GetService.googleMapKey)
        
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.versionCheck), userInfo: nil, repeats: false)
        
        return true
    }
    
    func versionCheck() {
        
        if NetWorkUtil.needUpdate() == true {
            
            // get Current View
            guard let rvc = self.window?.rootViewController else {
                return
            }
            
            if let vc = getCurrentViewController(rvc) {
                // do your stuff here
                
                let alert = UIAlertController(title: "알림", message: "새로운 버전이 출시 되었습니다. 앱을 다운로드 하시겠습니까?", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: showAppLink)
                let cancelAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                
                vc.present(alert, animated: true)
                
            }
        }
    }
    func showAppLink(alert: UIAlertAction){
        let url = URL(string: "https://itunes.apple.com/us/app/smartcampusinu/id1123199010?mt=8")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func configureAppearance() {
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = UIColor(netHex:0x3e536e)
        navigationBarAppearace.isTranslucent = false
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "AppleSDGothicNeo-Regular", size:18)!]
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    func timerPlay() {
        queue.async { [unowned self] in
            let currentRunLoop = RunLoop.current
            let timeInterval = 1.0
            self.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.sessionTimeCheck), userInfo: nil, repeats: true)
            self.timer.tolerance = timeInterval * 0.1
            currentRunLoop.add(self.timer, forMode: .commonModes)
            currentRunLoop.run()
            
        }
    }
    
    func sessionTimeCheck() {
        timeCount = timeCount + 1
        print(timeCount)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        //timerPlay()
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if let navigationController = self.window?.rootViewController as? UINavigationController {
            
            navigationController.popToRootViewController(animated: true)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // GetCurrentViewController
    func getCurrentViewController(_ vc: UIViewController) -> UIViewController? {
        if let pvc = vc.presentedViewController {
            return getCurrentViewController(pvc)
        }
        else if let svc = vc as? UISplitViewController, svc.viewControllers.count > 0 {
            return getCurrentViewController(svc.viewControllers.last!)
        }
        else if let nc = vc as? UINavigationController, nc.viewControllers.count > 0 {
            return getCurrentViewController(nc.topViewController!)
        }
        else if let tbc = vc as? UITabBarController {
            if let svc = tbc.selectedViewController {
                return getCurrentViewController(svc)
            }
        }
        return vc
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SmartCampus")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

