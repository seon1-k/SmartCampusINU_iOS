//
//  NoticeViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!

    var requestURL : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: gsno(requestURL))
        let request = NSURLRequest(url: url!)
        webView.loadRequest(request as URLRequest)
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
