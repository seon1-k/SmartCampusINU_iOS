//
//  TodayViewController.swift
//  TimeTableWidget
//
//  Created by BLU on 2017. 4. 6..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import NotificationCenter

private let reuseIdentifier = "Cell"

class TimeTableViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var weekView: WeekView!
    @IBOutlet weak var timeView: TimeView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        initView()
    }
    func initView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.itemSize = CGSize(width: (DeviceUtil.knowScreenWidth() - 50) / 5 , height: (DeviceUtil.knowScreenWidth() - 50) / 5 + 5)
            
        }
        
        self.collectionView.bounces = false
        
        self.collectionView.register(UINib(nibName: "TimeTableViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        //timeView.layer.borderColor = UIColor.lightGray.cgColor
    }
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        completionHandler(NCUpdateResult.newData)
    }
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
//        if activeDisplayMode == NCWidgetDisplayMode.compact
//        {
        self.preferredContentSize = CGSize(width: maxSize.width, height: maxSize.height)
//        }
//        else
//        {
//            self.preferredContentSize = CGSize(width: maxSize.width, height: maxSize.height)
//        }
    }
    
}
extension TimeTableViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return 75
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TimeTableViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
}
