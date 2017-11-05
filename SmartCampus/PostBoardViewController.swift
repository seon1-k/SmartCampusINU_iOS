//
//  PostBoardViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class PostBoardViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    let userDefaults = Foundation.UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleTextField.layer.borderWidth = 0.5
        self.titleTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.contentTextView.layer.borderWidth = 0.5
        self.contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "등록", style: .plain, target: self, action: #selector(PostBoardViewController.writePost))
        
    }
    func writePost() {
        guard let titleText = self.titleTextField.text, !titleText.isEmpty else { return }
        guard let contentText = self.contentTextView.text, !contentTextView.text.isEmpty else { return }
        
        PostService.writeBoard(stuid: gsno(self.userDefaults.string(forKey: "stuid")), title: titleText, date: DateUtil.getCurrentTime(), content: contentText) { response in
            switch response.result {
            case .success,
                 .failure where response.response?.statusCode != 409:
                print("성공")
                let queue = DispatchQueue.global()
                
                let vc = self.navigationController?.viewControllers[1] as! BoardListViewController
                vc.getBoards()
                
                queue.async { () -> Void in
                    DispatchQueue.main.async {
                        
                        self.navigationController?.popToViewController(vc, animated: true)
                    
                        vc.collectionView.reloadData()
                        vc.collectionView?.setContentOffset(CGPoint.zero, animated: true)
                        
                    }
                }
                
                
            case .failure:
                print("실패")
                
            }
        }
        
    }
    
}
