//
//  AppViewController.swift
//  smartCampus
//
//  Created by JYNG on 2017. 5. 2..
//  Copyright © 2016년 BLU. All rights reserved.
//

import UIKit

class AppViewController : UIViewController {
    
    @IBOutlet weak var adHeight: NSLayoutConstraint!
    @IBOutlet weak var facebookLinkView: UIView!
    @IBOutlet weak var appLinkView: UIView!
    @IBOutlet weak var appInuResView: UIImageView!
    @IBOutlet weak var appInuTelView: UIImageView!
    
    @IBOutlet weak var appInuResHeight: NSLayoutConstraint!
    @IBOutlet weak var appInuResWidth: NSLayoutConstraint!
    @IBOutlet weak var appTelResHeight: NSLayoutConstraint!
    @IBOutlet weak var appTelWidth: NSLayoutConstraint!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "앱센터"
        initMain()
        addView()
        
        
    }
    func initMain() {
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        
        adHeight.constant = DeviceUtil.knowScreenHeight() / 3 + 20
        
        if (DeviceUtil.knowScreenHeight() <= 480){
            appInuResHeight.constant = 55
            appInuResWidth.constant = 55
            appTelResHeight.constant = 55
            appTelWidth.constant = 55
            //iphone 4s
        } else if (480 < DeviceUtil.knowScreenHeight() && DeviceUtil.knowScreenHeight() <= 568){
            appInuResHeight.constant = 60
            appInuResWidth.constant = 60
            appTelResHeight.constant = 60
            appTelWidth.constant = 60
            
            //iphone 5,5s,SE
        } else if (568 < DeviceUtil.knowScreenHeight() && DeviceUtil.knowScreenHeight() <= 667){
            //iphone 6,6s
        } else if (667 < DeviceUtil.knowScreenHeight() && DeviceUtil.knowScreenHeight() <= 736){
            
        }
        
        self.appLinkView.layer.borderWidth = 1
        self.appLinkView.layer.borderColor = UIColor.init(netHex: 0xe5e5e5).cgColor
        addView()
        
    }
    //#selector(BoardViewController.keyboardWillShow(notification:))
    func addView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openUIAPP))
        self.facebookLinkView.addGestureRecognizer(gesture)
        
        let tapResIcon = UITapGestureRecognizer(target: self, action: #selector(openResLink))
        let tapTelIcon = UITapGestureRecognizer(target: self, action: #selector(tapTelLink))
        self.appInuResView.addGestureRecognizer(tapResIcon)
        self.appInuTelView.addGestureRecognizer(tapTelIcon)
    }
    func openUIAPP(sender:UITapGestureRecognizer){
        let url = URL(string: "https://www.facebook.com/UIAppCenter")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    func openResLink(sender:UITapGestureRecognizer){
        let url = URL(string: "https://geo.itunes.apple.com/kr/app/inurestaurant/id1089875861?mt=8")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    func tapTelLink(sender:UITapGestureRecognizer){
        let url = URL(string: "https://geo.itunes.apple.com/kr/app/inujeonhwabeonhobu/id830679351?mt=8")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
