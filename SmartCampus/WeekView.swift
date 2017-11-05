//
//  WeekView.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 7..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class WeekView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!

    let nibName = "WeekView"
    var view : UIView!
    var days = ["MON", "TUE", "WED", "THU", "FRI"]
    
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
            layout.itemSize = CGSize(width: (DeviceUtil.knowScreenWidth() - 50) / 5 , height: 25)
            
        }
     
    self.collectionView.register(UINib(nibName: "WeekViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
    }
}

extension WeekView: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WeekViewCell
        
        cell.dayLabel.text = days[indexPath.item]
        
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
