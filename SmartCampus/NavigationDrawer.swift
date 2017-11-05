//
//  NavigationDrawer.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 23..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class NavigationDrawer: UIView {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var inuLinkButton: UIButton!
    @IBOutlet weak var libLinkButton: UIButton!
    @IBOutlet weak var dormLinkButton: UIButton!
    @IBOutlet weak var applyLinkButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var appInfoButton: UIButton!
    
    
    let nibName = "NavigationDrawer"
    var view : UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetUp()
        hideAll()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetUp()
        hideAll()
        
    }
    
    func xibSetUp() {
        
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
    }
    
    func loadViewFromNib() ->UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    func hideAll() {
        self.profileImage.isHidden = true
        self.majorLabel.isHidden = true
        self.nameLabel.isHidden = true
        self.inuLinkButton.isHidden = true
        self.libLinkButton.isHidden = true
        self.dormLinkButton.isHidden = true
        self.applyLinkButton.isHidden = true
        self.logoutButton.isHidden = true
        self.appInfoButton.isHidden = true
    }
    func showAll() {
        self.profileImage.isHidden = false
        self.majorLabel.isHidden = false
        self.nameLabel.isHidden = false
        self.inuLinkButton.isHidden = false
        self.libLinkButton.isHidden = false
        self.dormLinkButton.isHidden = false
        self.applyLinkButton.isHidden = false
        self.logoutButton.isHidden = false
        self.appInfoButton.isHidden = false
    }
    @IBAction func openInuWeb(_ sender: Any) {
        let url = URL(string: "http://www.inu.ac.kr/mbshome/mbs/mobile/index.do")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func openInuLib(_ sender: Any) {
        let url = URL(string: "http://mlib.inu.ac.kr")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func openInuDorm(_ sender: Any) {
        let url = URL(string: "https://www.dorm.co.kr")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func openInuApply(_ sender: Any) {
        let url = URL(string: "http://www.google.com")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    
    
}
