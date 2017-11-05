//
//  MainButtonCell.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 24..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

enum buttonType: Int {
    case notice, academy, timeschedule, readingroom, restaurant, grade, campusmap, board, appcenter
    
    var imageName: String {
        switch self {
        case .notice:
            return "2-notice"
        case .academy:
            return "2-academy"
        case .timeschedule:
            return "2-timeschedule"
        case .readingroom:
            return "2-library"
        case .restaurant:
            return "2-restaurant"
        case .grade:
            return "2-grade"
        case .campusmap:
            return "2-campusmap"
        case .board:
            return "2-board"
        case .appcenter:
            return "2-appcenter"
        }
    }
    
    var image: UIImage {
        return UIImage(named: self.imageName)!
    }
    
    var connectedView: UIViewController {
        switch self {
        case .notice:
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "swipeviewcontroller")
        case .academy:
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "swipeviewcontroller")
        case .timeschedule:
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "swipeviewcontroller")
        case .readingroom:
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "readingroomlistviewcontroller") as! ReadingRoomListViewController
        case .restaurant:
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "swipeviewcontroller")
        case .grade:
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "swipeviewcontroller")
//            return GradeViewController()
        case .campusmap:
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "campusmapviewcontroller")
        case .board:
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "boardlistviewcontroller")
        case .appcenter:
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "appviewcontroller")
        }
    }
    
    
}

class MainButtonCell: UICollectionViewCell {
    var imageButton = UIButton()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.imageButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        self.addSubview(self.imageButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDefaultImage(idx: Int) {
        
        if let img = buttonType(rawValue: idx)?.image {
            self.imageButton.setBackgroundImage(img, for: .normal)
        }
        else {
            
        }
        
    }
    
    func buttonLongTapped() {
        
    }
    
    func buttonClicked(_ sender: UIButton) {
//        UIView.animate(withDuration: 0.6,
//                       animations: {
//                        self.imageButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
//                        
//        },
//                       completion: { _ in
//                        UIView.animate(withDuration: 0.6) {
//                            self.imageButton.transform = CGAffineTransform.identity
//                        }
//        })
    }
    
    func setClicked() {
        //self.imageButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(normalTap(_:)))
        //let longGesture = UILongPressGestureRecognizer(target: self, action: #selector((longTap(_:))))
        //imageButton.addGestureRecognizer(longGesture)
        //imageButton.addGestureRecognizer(tapGesture)
        
    }
    func normalTap(_ sender:UIGestureRecognizer){
        
        if sender.state == .ended {
            self.imageButton.backgroundColor = UIColor.clear
            self.imageButton.setBackgroundImage(UIImage(named:"2-notice"), for: .normal)
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began {
            self.imageButton.backgroundColor = UIColor.clear
            self.imageButton.setBackgroundImage(UIImage(named:"2-notice2"), for: .normal)
            print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
        }
    }
    
    func longTap(_ sender : UIGestureRecognizer){
        
        if sender.state == .ended {
            self.imageButton.backgroundColor = UIColor.clear
            self.imageButton.setBackgroundImage(UIImage(named:"2-notice"), for: .normal)
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began {
            self.imageButton.backgroundColor = UIColor.clear
            self.imageButton.setBackgroundImage(UIImage(named:"2-notice2"), for: .normal)
            print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
        }
    }
    
}

