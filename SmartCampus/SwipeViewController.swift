//
//  SwipeViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 26..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import Toaster

public class SwipeViewController : ButtonBarPagerTabStripViewController {
    
    var vcs : [UIViewController] = []
   
    var noticeTab = ["일반공지","모집/채용","학사공지","교육/시험일정"]
    
    let noticeContent: [(title: String, boardId: String)] = [
        ("전체", "48510"),
        ("일반공지", "49219"),
        ("모집/채용", "49235"),
        ("학사공지","49211"),
        ("교육/시험일정","307783")
        ]
    
    let menuContent: [(title: String, page: Int)] = [
        ("복지회관/카페테리아", 1),
        ("사범대식당/생활관", 2),
        ("교직원식당", 3)
    ]


    let gradeContent: [(title: String, page: Int)] = [
        ("학점", 1),
        ("확정전 성적", 2),
        ("졸업요건", 3)
    ]
    
    var terms:[Grade] = []
    var subTerms:[Grade] = []
    var grades:[Grade] = []
    
    var gradevc1: GradeViewController!
    
    var timescheduleVCS : [UIViewController] = [UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "timescheduleviewcontroller") as! TimeScheduleViewController, UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "classlistviewcontroller") as! ClassListViewController]
    var timescheduleVC = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "timescheduleviewcontroller") as! TimeScheduleViewController
    var classlistVC = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "classlistviewcontroller") as! ClassListViewController
        
    func test() {
        print("testtest")
    }
    public override func viewDidLoad() {
        
        
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.buttonBarItemFont = UIFont(name: "AppleSDGothicNeo-Regular", size:15)!
        self.settings.style.selectedBarBackgroundColor = UIColor(netHex: 0x3e536e)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor(red: 138/255.0, green: 138/255.0, blue: 144/255.0, alpha: 1.0)
            newCell?.label.textColor = .black
        }
        
        self.navigationController?.navigationBar.tintColor = .white
        //학기 정보 다운로드
        UserService.fetchTerm(Grade.self, success: { response in
            //print(response)
            //            self.terms = response
            for rs in response {
                switch rs.term {
                case "1":
                    fallthrough
                case "2":
                    self.terms.append(rs)
                    break
                case "3":
                    fallthrough
                case "4":
                    self.subTerms.append(rs)
                    break
                default:
                    break
                }
            }
            
            UserService.fetchGrade(Grade.self, success: { response in
                self.grades = response
            }){ (error) in
                
            }
            
        }){ (error) in
            
        }
//        print(terms)
        //        navigationItem.setRightBarButton(UIBarButtonItem(title: "", style: .plain, target: self, action: nil), animated: true)
        
        
        super.viewDidLoad()

    }
    
    // MARK: - PagerTabStripDataSource
    
    public override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        if let viewTitle = self.title {
            switch viewTitle {
            case "공지사항":
//                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More", style: .plain, target: self, action: "test")
                var i = 0
                
                for _ in noticeContent {
                    
                    let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "noticelistviewcontroller") as! NoticeListViewController
                    
                    vc.itemInfo = IndicatorInfo(title:noticeContent[i].title)
                    vc.boardId = gsno(noticeContent[i].boardId)
                    
                    
                    i = i + 1
                    vcs.append(vc)
                    
                }
                return vcs

            case "학사일정":
                for i in 1...12 {
                    
                    let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "academyviewcontroller") as! AcademyViewController
                  
                    vc.itemInfo = IndicatorInfo(title: "    " + String(i) + "월" + "    ")
                    vc.page = i
//                    GetService.fetchHaksa(Haksa.self, success: { response in
//                        print(response)
//                        for rs in response {
//                            self.haksa.append(rs)
//                            
//                            vc.page = i+1
//                            
//                            switch vc.page{
//                                
//                            case 1:
//                                
//                                vc.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
//                                vc.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate)) : "))
//                                vc.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
//                                print("01월 : \(vc.academic_content)")
//                                break
//                                
//                                
//                                //                                        case 2:
//                                //                                            vc.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
//                                //                                            vc.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate)) : "))
//                                //                                            vc.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
//                                //                                            print("02월 : \(vc.academic_content)")
//                                //                                            break
//                                
//                            default:
//                                break
//                                
//                            }
//                        }
//                        
//                        //                                    vc.calendarView.reloadData()
//                        
//                        
//                        
//                    }){ (error) in
//                        
//                    }
                    
                    
                    //자리수 2자리 이상 분기점으로 나눔
                    if i >= 10 {
                        vc.dateStr = "2017 " +  String(i) + " 01"
                    } else {
                        vc.dateStr = "2017 " + "0" + String(i) + " 01"
                    }
                    self.vcs.append(vc)
                }
                
                return vcs
                
            case "시간표":
                
                //let editButton   = UIBarButtonItem(image: UIImage(named:""),  style: .plain, target: self, action: Selector("didTapEditButton:"))
                //let shareButton = UIBarButtonItem(image: UIImage(named:"map-3"),  style: .plain, target: self, action: #selector(shareTimeSchedule))
                
                //navigationItem.rightBarButtonItems = [shareButton]
                for i in 0...1 {
                    switch i{
                    case 0:
                        timescheduleVC.itemInfo = IndicatorInfo(title: "시간표")
                        vcs.append(timescheduleVC)
                    case 1:
                        //timescheduleVCS[1].itemInfo = IndicatorInfo(title: "수강목록")
                        classlistVC.itemInfo = IndicatorInfo(title: "수강목록")
                        vcs.append(classlistVC)
                    default:
                        break
                    }
                }
                
                return vcs
            case "식당":
                var i = 0
                
                for _ in menuContent {
                    
                    let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "restaurantviewcontroller") as! RestaurantViewController
                    
                    vc.itemInfo = IndicatorInfo(title:menuContent[i].title)
//                    vc.boardId = gsno(noticeContent[i].boardId)
                    vc.page = i+1
                    switch vc.page {
                    case 1:
                        vc.name1 = "복지회관"
                        vc.name2 = "카페테리아"
                    case 2:
                        vc.name1 = "사범대식당"
                        vc.name2 = "생활관"
                    case 3:
                        vc.name1 = "교직원"
                    default:
                        print("default")
                    }
                    
                    i = i + 1
                    vcs.append(vc)
                    
                }
                return vcs
            case "학점":
                var i = 0
                for _ in gradeContent {
                    let vc = GradeViewController()
                    vc.itemInfo = IndicatorInfo(title: gradeContent[i].title)
                    vc.page = gradeContent[i].page
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "more_horizon"), style: .plain, target: self, action: #selector(moreClicked(_:)))
                    if i == 0 {
                        gradevc1 = vc
                        gradevc1.isAll = true
                        //                        gradevc1.term = nil
                    }
                    i = i + 1
                    vcs.append(vc)
                }
                return vcs
            case "게시판":
                let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "boardlistviewcontroller") as! BoardListViewController
                vcs.append(vc)
                return vcs
            default:
                break
            }
        }
        
        let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "noticelistviewcontroller") as! NoticeListViewController
        vc.itemInfo = IndicatorInfo(title:"일반공지")
        vc.boardId = "49219"
        
        
        let vc1 = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "noticelistviewcontroller") as! NoticeListViewController
        vc1.boardId = "49219"
        self.title = "공지사항"
        
        return [vc,vc1]
        
    }
    
    
}

extension SwipeViewController {
    
    func shareTimeSchedule() {
        
        if let cv = self.childViewControllers[0] as? TimeScheduleViewController {
            print("yes")
            
            cv.getSnapShot()
        }
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        
        let fileManager = FileManager.default
        let imagePath = (documentsDirectory as NSString).appendingPathComponent("timeschedule.jpg")
        
        if fileManager.fileExists(atPath: imagePath){
            let img = UIImage(contentsOfFile: imagePath)
            let vc = UIActivityViewController(activityItems: [img!], applicationActivities: [])
            self.present(vc, animated: true, completion: nil)
            
            
        }else{
            print("No Image")
        }

    }
    
}

extension SwipeViewController {
    //학점 뷰컨트롤러용 함수
    
    func moreClicked(_ sender: Any){
        //다른 학기 버튼
        
        //        print("tapped")
        //        print(self.subTerms)
        
        if let root = UIApplication.topViewController() {
            //            print(root)
            for rv in root.childViewControllers {
                if rv.isKind(of: GradeViewController.self) {
                    let gvc = rv as! GradeViewController
                    if gvc.page != 1 {
                        return
                    }
                }
            }
        }
        let no_term = "해당 학기 정보가 없습니다."
        
        let alert = UIAlertController(title: nil, message: "학기를 선택하세요", preferredStyle: .actionSheet)
        let allAction = UIAlertAction(title: "총학점", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.title = "학점"
            self.gradevc1.isAll = true
            NotificationCenter.default.post(name: .reloadGrade, object: nil)
        })
        let action11 = UIAlertAction(title: "1학년 1학기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if self.terms.count >= 1 {
                //                self.title = "1학년 1학기"
                self.gradevc1.isAll = false
                self.gradevc1.grades = self.getGrade(self.terms[0]).0
                self.gradevc1.tabData1[0] = String(self.getGrade(self.terms[0]).1)
                self.gradevc1.tabData1[1] = String(self.getGrade(self.terms[0]).2)
                self.gradevc1.tabData1[2] = String(self.getGrade(self.terms[0]).3)
                NotificationCenter.default.post(name: .reloadGrade, object: nil)
                //                self.gradevc1.term = self.terms[0]
            } else {
                Toast(text: no_term).show()
            }
        })
        let action12 = UIAlertAction(title: "1학년 2학기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if self.terms.count >= 2 {
                //                self.title = "1학년 2학기"
                self.gradevc1.isAll = false
                self.gradevc1.grades = self.getGrade(self.terms[1]).0
                self.gradevc1.tabData1[0] = String(self.getGrade(self.terms[1]).1)
                self.gradevc1.tabData1[1] = String(self.getGrade(self.terms[1]).2)
                self.gradevc1.tabData1[2] = String(self.getGrade(self.terms[1]).3)
                NotificationCenter.default.post(name: .reloadGrade, object: nil)
                //                self.gradevc1.term = self.terms[1]
            } else {
                Toast(text: no_term).show()
            }
        })
        let action21 = UIAlertAction(title: "2학년 1학기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if self.terms.count >= 3 {
                //                self.title = "2학년 1학기"
                self.gradevc1.isAll = false
                self.gradevc1.grades = self.getGrade(self.terms[2]).0
                self.gradevc1.tabData1[0] = String(self.getGrade(self.terms[2]).1)
                self.gradevc1.tabData1[1] = String(self.getGrade(self.terms[2]).2)
                self.gradevc1.tabData1[2] = String(self.getGrade(self.terms[2]).3)
                NotificationCenter.default.post(name: .reloadGrade, object: nil)
                //                self.gradevc1.term = self.terms[2]
            } else {
                Toast(text: no_term).show()
            }
        })
        let action22 = UIAlertAction(title: "2학년 2학기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if self.terms.count >= 4 {
                //                self.title = "2학년 2학기"
                self.gradevc1.isAll = false
                self.gradevc1.grades = self.getGrade(self.terms[3]).0
                self.gradevc1.tabData1[0] = String(self.getGrade(self.terms[3]).1)
                self.gradevc1.tabData1[1] = String(self.getGrade(self.terms[3]).2)
                self.gradevc1.tabData1[2] = String(self.getGrade(self.terms[3]).3)
                NotificationCenter.default.post(name: .reloadGrade, object: nil)
                //                self.gradevc1.term = self.terms[3]
            } else {
                Toast(text: no_term).show()
            }
        })
        let action31 = UIAlertAction(title: "3학년 1학기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if self.terms.count >= 5 {
                //                self.title = "3학년 1학기"
                self.gradevc1.isAll = false
                self.gradevc1.grades = self.getGrade(self.terms[4]).0
                self.gradevc1.tabData1[0] = String(self.getGrade(self.terms[4]).1)
                self.gradevc1.tabData1[1] = String(self.getGrade(self.terms[4]).2)
                self.gradevc1.tabData1[2] = String(self.getGrade(self.terms[4]).3)
                NotificationCenter.default.post(name: .reloadGrade, object: nil)
                //                self.gradevc1.term = self.terms[4]
            } else {
                Toast(text: no_term).show()
            }
        })
        let action32 = UIAlertAction(title: "3학년 2학기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if self.terms.count >= 6 {
                //                self.title = "3학년 2학기"
                self.gradevc1.isAll = false
                self.gradevc1.grades = self.getGrade(self.terms[5]).0
                self.gradevc1.tabData1[0] = String(self.getGrade(self.terms[5]).1)
                self.gradevc1.tabData1[1] = String(self.getGrade(self.terms[5]).2)
                self.gradevc1.tabData1[2] = String(self.getGrade(self.terms[5]).3)
                NotificationCenter.default.post(name: .reloadGrade, object: nil)
                //                self.gradevc1.term = self.terms[5]
            } else {
                Toast(text: no_term).show()
            }
        })
        let action41 = UIAlertAction(title: "4학년 1학기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if self.terms.count >= 7 {
                //                self.title = "4학년 1학기"
                self.gradevc1.isAll = false
                self.gradevc1.grades = self.getGrade(self.terms[6]).0
                self.gradevc1.tabData1[0] = String(self.getGrade(self.terms[6]).1)
                self.gradevc1.tabData1[1] = String(self.getGrade(self.terms[6]).2)
                self.gradevc1.tabData1[2] = String(self.getGrade(self.terms[6]).3)
                NotificationCenter.default.post(name: .reloadGrade, object: nil)
                //                self.gradevc1.term = self.terms[6]
            } else {
                Toast(text: no_term).show()
            }
        })
        let action42 = UIAlertAction(title: "4학년 2학기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if self.terms.count >= 8 {
                //                self.title = "4학년 2학기"
                self.gradevc1.isAll = false
                self.gradevc1.grades = self.getGrade(self.terms[7]).0
                self.gradevc1.tabData1[0] = String(self.getGrade(self.terms[7]).1)
                self.gradevc1.tabData1[1] = String(self.getGrade(self.terms[7]).2)
                self.gradevc1.tabData1[2] = String(self.getGrade(self.terms[7]).3)
                NotificationCenter.default.post(name: .reloadGrade, object: nil)
                //                self.gradevc1.term = self.terms[7]
            } else {
                Toast(text: no_term).show()
            }
        })
        
        let actionSummer = UIAlertAction(title: "여름학기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
//            self.title = "여름학기"
            let term = Grade()
            term.term = "3"
            self.gradevc1.isAll = false
            self.gradevc1.grades = self.getGrade(term).0
            self.gradevc1.tabData1[0] = String(self.getGrade(term).1)
            self.gradevc1.tabData1[1] = String(self.getGrade(term).2)
            self.gradevc1.tabData1[2] = ""
            NotificationCenter.default.post(name: .reloadGrade, object: nil)
            //            self.gradevc1.term = Grade()
            //            self.gradevc1.term.year = "0"
            //            self.gradevc1.term.term = "3"
        })
        let actionWinter = UIAlertAction(title: "겨울학기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
//            self.title = "겨울학기"
            let term = Grade()
            term.term = "4"
            self.gradevc1.isAll = false
            self.gradevc1.grades = self.getGrade(term).0
            self.gradevc1.tabData1[0] = String(self.getGrade(term).1)
            self.gradevc1.tabData1[1] = String(self.getGrade(term).2)
            self.gradevc1.tabData1[2] = ""
            NotificationCenter.default.post(name: .reloadGrade, object: nil)
            //            self.gradevc1.term = Grade()
            //            self.gradevc1.term.year = "0"
            //            self.gradevc1.term.term = "4"
        })
        alert.addAction(allAction)
        alert.addAction(action11)
        alert.addAction(action12)
        alert.addAction(action21)
        alert.addAction(action22)
        alert.addAction(action31)
        alert.addAction(action32)
        alert.addAction(action41)
        alert.addAction(action42)
        alert.addAction(actionSummer)
        alert.addAction(actionWinter)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func getGrade(_ term: Grade) -> ([Grade], Int, Int, Float) {
        var result:[Grade] = []
        
        var apply_credit = 0
        var acquire_credit = 0
        var sum_credit:Float = 0.0
        
        let year = term.year
        let term = term.term
        
        if term == "1" || term == "2" {
            //일반학기
            for grade in self.grades {
                if grade.year == year && grade.term == term {
                    result.append(grade)
                    apply_credit += grade.credit
                    if grade.give_up_yn == "N" && grade.score != "0" {
                        acquire_credit += grade.credit
                        sum_credit += Float(grade.credit) * (grade.score as NSString).floatValue
                    } else if grade.give_up_yn == "N" && grade.get_rank == "P" {
                        acquire_credit += grade.credit
                    }
                }
            }
            sum_credit /= Float(acquire_credit)
            if acquire_credit == 0 {
                sum_credit = 0.0
            }
        } else {
            //계절학기
            for grade in self.grades {
                if grade.term == term {
                    result.append(grade)
                    apply_credit += grade.credit
                    if grade.give_up_yn == "N" && grade.score != "0" {
                        acquire_credit += grade.credit
                        //                        sum_credit += Float(grade.credit) * (grade.score as NSString).floatValue
                    } else if grade.give_up_yn == "N" && grade.get_rank == "P" {
                        acquire_credit += grade.credit
                    }
                }
            }
        }
        sum_credit = sum_credit.roundToPlaces(places: 2)
        return (result, apply_credit, acquire_credit, sum_credit)
    }
    
}

extension UIApplication
{
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        if let nav = base as? UINavigationController
        {
            let top = topViewController(nav.visibleViewController)
            return top
        }
        
        if let tab = base as? UITabBarController
        {
            if let selected = tab.selectedViewController
            {
                let top = topViewController(selected)
                return top
            }
        }
        
        if let presented = base?.presentedViewController
        {
            let top = topViewController(presented)
            return top
        }
        return base
    }
}


