//
//  ClassInfoViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 8..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

class ClassInfoViewController: UIViewController {
    
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var profLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var textBookLabel: UILabel!
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var studentInfoButton: UIButton!
    
    
    var subjectId = ""
    var courseNameText = ""
    var profText = ""
    
    
    var classInfo = ClassInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentInfoButton.layer.borderColor = UIColor.darkGray.cgColor
        
        UserService.fetchClassInfo(self.subjectId) { response in
            switch response.result {
                
            case .success(let value):
                print(value.prof)
                
                self.courseNameText = value.course_name
                self.profText = value.prof
                
                self.courseNameLabel.text = value.course_name
                self.profLabel.text = value.prof + " 교수님"
                self.roomLabel.text = value.room
                self.dayLabel.text = value.day
                self.textBookLabel.text = value.textbook
                self.goalTextView.text = value.goal
                
                
            case .failure(let error):
                print("정보 받아오지 못함", error)
                
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showStudentList(_ sender: Any) {
        let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "studentlistviewcontroller") as! StudentListViewController
        vc.subjectId = self.subjectId
        vc.courseNameText = self.courseNameText
        vc.profText = self.profText
        vc.title = "수강인정보"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
