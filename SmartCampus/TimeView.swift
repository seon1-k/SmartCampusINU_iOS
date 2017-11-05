//
//  TimeView.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 8..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TimeView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let nibName = "TimeView"
    var view : UIView!
    var starts : [(period: String, time: String)] = [("0", "08:00"), ("1", "09:00"),("2", "10:00"), ("3", "11:00"),("4", "12:00"), ("5", "13:00"), ("6", "14:00"), ("7", "15:00"), ("8", "16:00"), ("9", "17:00"), ("10", "18:00"), ("11", "18:55"), ("12", "19:50"), ("13", "20:45"), ("14", "21:40")]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetUp()
        initView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetUp()
        initView()
    }
    
    func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func initView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.itemSize = CGSize(width: 50, height: (DeviceUtil.knowScreenWidth() - 50) / 5 + 5)
            
        }
        
    self.collectionView.register(UINib(nibName: "TimeViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
    }
}

extension TimeView: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TimeViewCell
        
        cell.periodLabel.text = starts[indexPath.item].period
        cell.timeLabel.text = starts[indexPath.item].time
        
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
