//
//  AlertView+ActivityIndicator.swift
//  SmartCampus
//
//  Created by BLU on 2017. 5. 1..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

let activityData = ActivityData(size: CGSize(width: 40, height: 40), message: "로딩중입니다...", messageFont: UIFont(name: "HelveticaNeue-Bold", size:16)!, type: NVActivityIndicatorType.ballPulse , color: UIColor.white, padding: 0, displayTimeThreshold: 5, minimumDisplayTime: 0, backgroundColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), textColor: UIColor.white)

let loadIndicatorData = ActivityData(size: CGSize(width: 50, height: 50), message: "", messageFont: UIFont(name: "HelveticaNeue-Bold", size:16)!, type: NVActivityIndicatorType.ballClipRotate , color: UIColor.lightGray, padding: 0, displayTimeThreshold: 5, minimumDisplayTime: 0, backgroundColor: UIColor.clear, textColor: UIColor.black)

let Indicator = NVActivityIndicatorPresenter.sharedInstance

