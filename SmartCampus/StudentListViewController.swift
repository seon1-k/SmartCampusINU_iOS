//
//  ClassStudentViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 9..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class StudentListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var profLabel: UILabel!
    
    var subjectId = ""
    var profText = ""
    var courseNameText = ""
    
    var students = [Student]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        UserService.fetchStudentList(self.subjectId, Student.self, success: { response in
            
            
            for rs in response {
                self.students.append(rs)
            }
            
            self.collectionView.reloadData()
            
        }){ (error) in
            
        }
        
    }
    
    func initView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.courseLabel.text = courseNameText
        self.profLabel.text = profText + " 교수님"
        self.collectionView.register(UINib(nibName: "StudentViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}

extension StudentListViewController :
UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource{
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return students.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StudentViewCell
        
        cell.backgroundColor = UIColor.white
        cell.dividerView.isHidden = true
        
        if indexPath.item % 4 == 0 {
            cell.dividerView.isHidden = false
        }
        
        if (indexPath.item % 4 == 2 || indexPath.item % 4 == 3) {
            
            cell.backgroundColor = UIColor(red: 102/255, green: 153/255, blue: 102/255, alpha: 0.2)
            
        }
        
        cell.nameLabel.text = students[indexPath.item].name
        cell.departLabel.text = students[indexPath.item].department
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    
    // MARK: - UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (DeviceUtil.knowScreenWidth() - 40) / 2, height: 50)
    }
    
    
}
