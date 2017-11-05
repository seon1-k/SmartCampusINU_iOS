//
//  TimeSecheduleViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 29..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

private let reuseIdentifier = "Cell"

class renderSubject {
    var name: String
    var day: String
    var prof: String
    var color: String
    var start_time: String
    var end_time: String
    var isFirstChecked: Bool
    var id: String
    
    init(name: String, day:String, prof: String, color:String, start_time: String, end_time: String, isFirstChecked: Bool, id: String) {
        self.name = name
        self.day = day
        self.prof = prof
        self.color = color
        self.start_time = start_time
        self.end_time = end_time
        self.isFirstChecked = isFirstChecked
        self.id = id
    }
}

class TimeScheduleViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var weekView: WeekView!
    @IBOutlet weak var timeView: TimeView!
    var rs = [renderSubject]()
    var colorList : [String] = ["0xF5998E","0x5CAD82", "0xFFCF57", "0x73A2C9", "0xDBA4DD", "0x86D0C1", "0xFF9966", "0x84C176", "0xF4706E", "0xABC971", "0xAEA8D3", "0x67809F", "0xFFC166", "0x90C695", "0xED6A58"]
    let timeString: [(
        start: String,
        end: String
        )] = [
        ("오전 08:00", "오전 08:50"),
        ("오전 09:00", "오전 09:50"),
        ("오전 10:00", "오전 10:50"),
        ("오전 11:00", "오전 11:50"),
        ("오전 12:00", "오후 12:50"),
        ("오후 01:00", "오후 01:50"),
        ("오후 02:00", "오후 02:50"),
        ("오후 03:00", "오후 03:50"),
        ("오후 04:00", "오후 04:50"),
        ("오후 05:00", "오후 05:50"),
        ("오후 06:00", "오후 06:50"),
        ("오후 06:55", "오후 07:45"),
        ("오후 07:50", "오후 08:40"),
        ("오후 08:45", "오후 09:35"),
    ]
    
    
    let userDefaults = Foundation.UserDefaults.standard
    
    //let realm = try! Realm()
    
    fileprivate var subjects : [Subject] = []
    
    var distinctSubs = Set<String>()
    var distSubsWithColor = [(String, String)]()
    var subjectsWithColor = [(String, String)]()
    var itemInfo = IndicatorInfo(title: "View")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.randomizeColors()
        self.fetchTimeTable()
        
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
        
        timeView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func randomizeColors() {
        
        if let userColor = userDefaults.object(forKey: "color\(gsno(self.userDefaults.string(forKey: "stuid")))") {
            print(userColor)
            
        } else {
            
            print("랜덤값은?")
            colorList.shuffle()
            for i in colorList {
                print(i)
            }
            userDefaults.set(colorList, forKey: "color\(gsno(self.userDefaults.string(forKey: "stuid")))")
        }
    }
    func fetchTimeTable() {
        
        UserService.fetchTimeSchedule(Subject.self, success: { response in
            
            //if self.realm.objects(Subject.self).count < 1 {
            
            for sub in response {
                
                if self.distinctSubs.contains(sub.id) {
                    for i in self.distSubsWithColor {
                        if (i.0 == sub.id) {
                            sub.color = i.1
                            
                        }
                    }
                    
                } else {
                    self.distinctSubs.insert(sub.id)
                    sub.color = self.colorList[0]
                    self.distSubsWithColor.insert((sub.id, self.colorList[0]), at: 0)
                    self.colorList.remove(at: 0)
                    
                }
                
                self.subjects.append(sub)
                
            }
            
            print(self.subjects)
            self.divideSubjectTime()
            self.collectionView?.reloadData()
        }){ (error) in
            
        }
        
    }
    
    func divideSubjectTime() {
        
        
        for sub in subjects {
            
            for div in 0 ... Int(sub.end_time)! - Int(sub.start_time)! {
                var isFirstChecked = false
                if div == 0 {
                    isFirstChecked = true
                }
                self.rs.append(renderSubject(name: sub.name, day: sub.day, prof: sub.prof, color: sub.color, start_time: String(Int(sub.start_time)! + div), end_time: sub.end_time, isFirstChecked: isFirstChecked, id: sub.id))
                
            }
            
            
        }
        self.collectionView.reloadData()
        print("결과임")
        
        for r in rs {
            print(r.start_time)
        }
        
        
    }
    
    func getSnapShot() {
        
        var image : UIImage?
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: DeviceUtil.knowScreenWidth(), height: self.collectionView.contentSize.height + 25), false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        let previousFrame = CGRect(x: 0, y: 25, width: DeviceUtil.knowScreenWidth(), height: self.view.frame.height)
        self.collectionView.frame = CGRect(x: self.collectionView.frame.origin.x, y: self.collectionView.frame.origin.y, width: self.collectionView.contentSize.width, height: self.collectionView.contentSize.height)
        
        self.view.layer.render(in: context!)
        
        self.collectionView.frame = previousFrame
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("timeschedule.jpg")
        
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        
        
    }
    
}

extension TimeScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
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
        
        cell.backgroundColor = nil
        cell.backgroundColor = UIColor.white
        cell.bottomLabel.isHidden = true
        cell.topLabel.isHidden = true
        cell.subjectLabel.isHidden = true
        //
        
        for sub in rs {
            
            var value : Int?
            
            switch sub.day {
            case "월":
                value = 0
                break
            case "화":
                value = 1
                break
            case "수":
                value = 2
                break
            case "목":
                value = 3
                break
            case "금":
                value = 4
                break
            default:
                break
            }
            
            if (indexPath.item / 5) == Int(sub.start_time)! && (indexPath.item % 5 == value!) {
                
                cell.backgroundColor = UIColor(hexString: sub.color)
                
                if sub.isFirstChecked {
                    cell.subjectLabel.isHidden = false
                    cell.topLabel.isHidden = false
                    cell.topLabel.text = timeString[Int(sub.start_time)! - 1].start
                    cell.subjectLabel.text = sub.name
                }
                
                if Int(sub.start_time) == Int(sub.end_time) {
                    cell.bottomLabel.isHidden = false
                    cell.bottomLabel.text = timeString[Int(sub.end_time)! - 1].end
                }
                
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var value : Int?
        for sub in rs {
            
            switch sub.day {
            case "월":
                value = 0
                break
            case "화":
                value = 1
                break
            case "수":
                value = 2
                break
            case "목":
                value = 3
                break
            case "금":
                value = 4
                break
            default:
                break
            }
            
            if (indexPath.item / 5) == Int(sub.start_time)! && (indexPath.item % 5 == value!) {
                print("있음")
                print("시작시간")
                let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "classinfoviewcontroller") as! ClassInfoViewController
                vc.subjectId = sub.id
                vc.title = "강의정보"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
}
extension TimeScheduleViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        timeView.collectionView.contentOffset.y = scrollView.contentOffset.y
    }
}

extension TimeScheduleViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

