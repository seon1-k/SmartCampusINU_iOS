//
//  ReadingRoomViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 28..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class ReadingRoomViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var requestURL : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: gsno(requestURL))
        let request = NSURLRequest(url: url!)
        webView.loadRequest(request as URLRequest)
    }
    
}
