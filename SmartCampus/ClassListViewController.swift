//
//  ClassListViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 28..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import XLPagerTabStrip

private let reuseIdentifier = "Cell"

class ClassListViewController: UICollectionViewController {
    
    var itemInfo = IndicatorInfo(title: "View")
    
    var classes : [Class] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UINib(nibName: "ClassViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        UserService.fetchClassList(Class.self, success: { response in
            print(response)
            //self.boards = response
            
            for rs in response {
                self.classes.append(rs)
            }
            
            
            self.collectionView?.reloadData()
        }){ (error) in
            
        }
    }
}

extension ClassListViewController :UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return classes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ClassViewCell
        
        cell.subjectLabel?.text = classes[indexPath.item].subjectname
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "classinfoviewcontroller") as! ClassInfoViewController
        vc.subjectId = classes[indexPath.item].subjectid
        vc.title = "강의정보"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        
        return UIEdgeInsetsMake(10, 0, 10, 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 10
    }
    
    // MARK: - UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: DeviceUtil.knowScreenWidth() - 20, height: 60)
    }
    
    
}

extension ClassListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
