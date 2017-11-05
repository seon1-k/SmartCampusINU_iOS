//
//  GradeViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire

private let topCellId = "topCell"
private let bottomCellId = "bottomCell"
private let bottomCellId2 = "bottomCell2"

class GradeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 1~8 정규학기 9~10 계절학기
    //    var term = 0
    //    var terms:[Grade] = [] //학기 정보
    
    //    var term:Grade!
    var isAll:Bool = true
    var grades:[Grade] = [] //학점 목록
    var befGrade:[BeforeGrade] = [] //확정 전 성적 목록
    
    let prefs = UserDefaults.standard
    
    var itemInfo = IndicatorInfo(title: "View")
    var page = -1
    
    let tabTitle1:[String] = ["신청학점", "취득학점", "학기평점"]
    let tabTitle3:[String] = ["나의 현재학점", "필요 학점", "졸업 학점"]
    var tabData1:[String] = ["", "", ""]
    
    var tot_credit = 0 //취득하검
    var tot_avg = 0.0
    
    
    lazy var topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 102/255, green: 153/255, blue: 102/255, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        return cv
        //113 151 107
    }()
    
    lazy var bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let bottomView: GraduateView = GraduateView()
    
    //    var allgrade: AllGrade?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView(_:)), name: .reloadGrade, object: nil)
        
        switch page {
        case 3:
            fallthrough
        case 1:
            reloadData()
            break
        case 2:
            getBeforeGrade()
//            'select year,student_no,subject_nm,isu_div,credit,score,get_rank,bigo,grade_type from v_campus_05 where student_no = :sno';
//            self.tabData1[0] = ""
//            self.tabData1[1] = "34"
//            self.tabData1[2] = "56"
            break
        default:
            break
        }
    }
    
    func getBeforeGrade() {
        //확정 전 성적 불러오기
        UserService.fetchBefGrade(BeforeGrade.self, success: { response in
//            print(response)
            self.befGrade = response
            
            self.topCollectionView.reloadData()
            self.bottomCollectionView.reloadData()
        }){ (error) in
            
        }
    }
    
    func reloadData() {
        if self.isAll == true {
            //전체 취득학점 및 평균 학점 받아오기
            UserService.fetchAllGrade(AllGrade.self, success: { response in
                print(response)
                for rs in response {
                    //                self.allgrade = rs
                    self.tabData1[0] = String(rs.apply_credit)
                    self.tabData1[1] = String(rs.tot_credit)
                    self.tabData1[2] = String(rs.tot_avg)
                    self.tot_credit = rs.tot_credit
                    self.tot_avg = rs.tot_avg
                }
                self.topCollectionView.reloadData()
                self.bottomCollectionView.reloadData()
            }){ (error) in
                
            }
        } else {
            self.topCollectionView.reloadData()
            self.bottomCollectionView.reloadData()
        }
    }
    
    func reloadCollectionView(_ notification: Notification) {
        reloadData()
        self.topCollectionView.reloadData()
        self.bottomCollectionView.reloadData()
    }
    
    func initView(){
        topCollectionView.register(GradeTopCell.self, forCellWithReuseIdentifier: topCellId)
        view.addSubview(topCollectionView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: topCollectionView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: topCollectionView)
        view.addConstraint(NSLayoutConstraint(item: topCollectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        
        //탭에 따라 하단에 collectionview 가 올 것인지 view 가 올 것인지 결정
        switch self.page {
        case 1:
            fallthrough
        case 2:
            bottomCollectionView.register(GradeBottomCell.self, forCellWithReuseIdentifier: bottomCellId)
            bottomCollectionView.register(GradeBottomPointCell.self, forCellWithReuseIdentifier: bottomCellId2)
            view.addSubview(bottomCollectionView)
            view.addConstraintsWithFormat(format: "H:[v0(\(DeviceUtil.knowScreenWidth()-40))]", views: bottomCollectionView)
            bottomCollectionView.frame.size.height = 100
            view.addConstraint(NSLayoutConstraint(item: bottomCollectionView, attribute: .top, relatedBy: .equal, toItem: topCollectionView, attribute: .bottom, multiplier: 1, constant: 20))
            view.addConstraint(NSLayoutConstraint(item: bottomCollectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -20))
            view.addConstraint(NSLayoutConstraint(item: bottomCollectionView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
            break
        case 3:
            view.addSubview(bottomView)
            view.addConstraintsWithFormat(format: "H:[v0(\(DeviceUtil.knowScreenWidth()-40))]", views: bottomView)
            bottomView.frame.size.height = 100
            view.addConstraint(NSLayoutConstraint(item: bottomView, attribute: .top, relatedBy: .equal, toItem: topCollectionView, attribute: .bottom, multiplier: 1, constant: 20))
            view.addConstraint(NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -20))
            view.addConstraint(NSLayoutConstraint(item: bottomView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
            bottomView.modifyBtn.addTarget(self, action: #selector(modifyClicked(_:)), for: .touchUpInside)
            break
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.topCollectionView {
            return 3
        } else if collectionView == self.bottomCollectionView {
            switch self.page {
            case 1:
                if self.isAll == false {
                    return grades.count
                }
                return 1
            case 2:
                return befGrade.count
            default:
                return 0
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.topCollectionView {
            return CGSize(width: DeviceUtil.knowScreenWidth() / 3, height: collectionView.frame.height)
        } else if collectionView == self.bottomCollectionView {
            return CGSize(width: collectionView.frame.size.width, height: 40)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.topCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellId, for: indexPath) as! GradeTopCell
            switch self.page {
            case 1:
                fallthrough
            case 2:
                cell.titleL.text = tabTitle1[indexPath.row]
                cell.dataL.text = tabData1[indexPath.row]
                break
            case 3:
                cell.titleL.text = tabTitle3[indexPath.row]
                switch indexPath.row {
                case 0:
                    cell.dataL.text = String(tot_credit)+"학점"
                    break
                case 1:
                    if prefs.object(forKey: "gradescore") != nil {
                        var score = (prefs.integer(forKey: "gradescore")-tot_credit)
                        if score < 0 {
                            score = 0
                        }
                        cell.dataL.text = String(score)+"학점"
                        
                    } else {
                        cell.dataL.text = ""
                    }
                    break
                case 2:
                    if prefs.object(forKey: "gradescore") != nil {
                        cell.dataL.text = String(prefs.integer(forKey: "gradescore"))+"학점"
                    }
                    break
                default:
                    break
                }
                break
            default:
                print("default")
            }
            return cell
        } else if collectionView == self.bottomCollectionView {
            
            switch self.page {
            case 1:
                if self.isAll == true {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bottomCellId, for: indexPath) as! GradeBottomCell
                    print("tot_avg:",tot_avg)
                    print("tot_credit:",tot_credit)
                    cell.avgL.text = String(tot_avg)
                    cell.pointL.text = String(tot_credit)
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bottomCellId2, for: indexPath) as! GradeBottomPointCell
                    cell.nameL.text = grades[indexPath.row].subject_name
                    cell.typeL.text = grades[indexPath.row].type
                    cell.creditL.text = String(grades[indexPath.row].credit)+"학점"
                    cell.rankL.text = grades[indexPath.row].get_rank
                    cell.scoreL.text = grades[indexPath.row].score
                    return cell
                }
            case 2:
                //확정 전 성적
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bottomCellId2, for: indexPath) as! GradeBottomPointCell
                let grade = befGrade[indexPath.row]
                cell.nameL.text = grade.subject_name
                cell.typeL.text = grade.isu_div
                cell.creditL.text = grade.credit+"학점"
                cell.rankL.text = grade.get_rank
                cell.scoreL.text = grade.bigo
                return cell
            default:
                print("default")
            }
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellId, for: indexPath)
        return cell
    }
    
    func modifyClicked(_ sender: UIButton){
        //졸업 학점 수정 버튼
        let alert = UIAlertController(title: "", message: "본인의 졸업 학점을 입력해주세요.\n(예: 140학점 -> 140)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: { action in
            self.prefs.set(Int((alert.textFields?[0].text)!), forKey: "gradescore")
            self.topCollectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
            textField.keyboardType = .numberPad
        })
        alert.actions[0].isEnabled = false
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true, completion: nil)
        })
    }
    func textChanged(_ sender: UITextField){
        var resp: UIResponder! = sender
        while !(resp is UIAlertController) { resp = resp.next }
        let alert = resp as! UIAlertController
        alert.actions[0].isEnabled = ((sender.text != "") && (Int(sender.text!) != nil))
    }
}

extension GradeViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

extension Notification.Name {
    static let reloadGrade = Notification.Name("reloadGrade")
}

class GraduateView: UIView {
    let titleL: UILabel = {
        let ul = UILabel(frame: .zero)
        ul.text = "① 졸업에 필요한 이수학점은 135학점 이상으로 하되 공과대학, 정보기술대학, 도시행정학과를 제외한 도시과학대학, 생명과학기술대학 생명공학부는 140학점 이상을 취득하여야 한다.\n② 교양과목은 30학점 이상 55학점까지 이수하여야 하고, 전공과목은 60학점 이상, 자연과학대학 수학과, 물리학과, 화학과, 해양학과 및 생명과학기술대학 생명과학부는 63학점 이상, 공과대학, 정보기술대학, 도시행정학과를 제외한 도시과학대학, 생명과학기술대학 생명공학부는 72학점 이상을 이수하여야 한다. 다만, 복수전공자의 전공과목은 주전공학과(전공)와 복수전공학과(전공)의 전공기초 및 전공필수과목을 포함하여 각각 42학점 이상을 이수하여야 한다.\n③ 제22조에 따라 수업연한을 단축하여 졸업하고자 하는 자는 총 성적평점평균이 4.0 이상이어야 한다."
        ul.lineBreakMode = .byWordWrapping
        ul.numberOfLines = 0
        ul.translatesAutoresizingMaskIntoConstraints = false
        ul.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        return ul
    }()
    
    let detailBtn: UIButton = {
        let ub = UIButton(frame: .zero)
        ub.backgroundColor = UIColor(red: 102/255, green: 153/255, blue: 102/255, alpha: 1)
        ub.setTitle("상세보기", for: .normal)
        ub.setTitleColor(.white, for: .normal)
        ub.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        ub.layer.borderWidth = 1
        ub.layer.borderColor = UIColor(red: 240, green: 240, blue: 240).cgColor
        ub.layer.masksToBounds = false
        ub.layer.shadowOffset = CGSize(width: 3, height: 0)
        ub.layer.shadowColor = UIColor(red: 240, green: 240, blue: 240).cgColor
        ub.layer.shadowRadius = 3
        ub.layer.shadowOpacity = 1
        return ub
    }()
    
    let modifyBtn: UIButton = {
        let ub = UIButton(frame: .zero)
        ub.backgroundColor = UIColor(red: 102/255, green: 153/255, blue: 102/255, alpha: 1)
        ub.setTitle("졸업학점\n입력/수정", for: .normal)
        ub.setTitleColor(.white, for: .normal)
        ub.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        ub.titleLabel?.numberOfLines = 0
        ub.titleLabel?.textAlignment = .center
        ub.layer.borderWidth = 1
        ub.layer.borderColor = UIColor(red: 240, green: 240, blue: 240).cgColor
        ub.layer.masksToBounds = false
        ub.layer.shadowOffset = CGSize(width: 3, height: 0)
        ub.layer.shadowColor = UIColor(red: 240, green: 240, blue: 240).cgColor
        ub.layer.shadowRadius = 3
        ub.layer.shadowOpacity = 1
        return ub
    }()
    
    func detailClicked(_ sender: UIButton){
        let url = URL(string: "http://rule.inu.ac.kr/sub/sub_2.jsp?idx=44")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(titleL)
        addConstraint(NSLayoutConstraint(item: titleL, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: titleL, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: titleL, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10))
        titleL.sizeToFit()
        
        addSubview(detailBtn)
        addConstraintsWithFormat(format: "H:[v0(70)]", views: detailBtn)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: detailBtn)
        addConstraint(NSLayoutConstraint(item: detailBtn, attribute: .leading, relatedBy: .equal, toItem: titleL, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: detailBtn, attribute: .top, relatedBy: .equal, toItem: titleL, attribute: .bottom, multiplier: 1, constant: 40))
        detailBtn.addTarget(self, action: #selector(detailClicked(_:)), for: .touchUpInside)
        
        addSubview(modifyBtn)
        addConstraintsWithFormat(format: "H:[v0(70)]", views: modifyBtn)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: modifyBtn)
        addConstraint(NSLayoutConstraint(item: modifyBtn, attribute: .leading, relatedBy: .equal, toItem: detailBtn, attribute: .trailing, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: modifyBtn, attribute: .top, relatedBy: .equal, toItem: titleL, attribute: .bottom, multiplier: 1, constant: 40))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GraduateLabel: UILabel {
    
    var topInset: CGFloat = 10
    var rightInset: CGFloat = 10
    var bottomInset: CGFloat = 0
    var leftInset: CGFloat = 10
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
        self.setNeedsLayout()
        return super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
