//
//  RestaurantViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import RxCocoa

private let loadURL = "String.serverStringrestaurant"
private let reuseIdentifier = "RestaurantViewCell"
private let sectionIdentifier = "HeaderCell"

class RestaurantViewController: UICollectionViewController {
//    var boardId : String?
    
    var itemInfo = IndicatorInfo(title: "View")
    
    var disposeBag = DisposeBag()
//    var notices : [Notice] = []
    
    var menus : [Menu] = []
    var menus2 : [Menu] = []
    var page = -1
    var name1:String = ""
    var name2:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetService.fetchMenu(requesturl: loadURL, name: name1) { response in
            self.menus = response
//            self.menus = self.resortArray(name: self.name1, array: self.menus)
//            self.collectionView?.reloadData()
            
            if self.name2 != "" {
                GetService.fetchMenu(requesturl: loadURL, name: self.name2) { response in
                    self.menus2 = response
//                    self.menus2 = self.resortArray(name: self.name2, array: self.menus2)
                    self.collectionView?.reloadData()
                }
            } else {
                self.collectionView?.reloadData()
            }
            
//            print("count :", self.collectionView?.numberOfItems(inSection: 0))
//            print(self.menus)
        }
        
        collectionView?.register(MenuViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.register(MenuSectionView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
        //        collectionView?.backgroundColor = .gray
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
//            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
            flowLayout.headerReferenceSize = CGSize(width: DeviceUtil.knowScreenWidth(), height: 40)
        }


    }
}

extension RestaurantViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
        switch page {
        case 1, 2:
            return 2
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return menus.count + menus2.count
        
        switch section {
        case 0:
            return menus.count
        case 1:
            return menus2.count
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuViewCell
        
        switch indexPath.section {
        case 0:
            cell.menuLabel.text = menus[indexPath.row].menu
            cell.cornerLabel.text = menus[indexPath.row].corner.replacingOccurrences(of: "_", with: "\n")
        case 1:
            cell.menuLabel.text = menus2[indexPath.row].menu
            cell.cornerLabel.text = menus2[indexPath.row].corner.replacingOccurrences(of: "_", with: "\n")
        default:
            print("default")
        }
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var menu = ""
        var corner = ""
        switch indexPath.section {
        case 0:
            menu = menus[indexPath.row].menu
            corner = menus[indexPath.row].corner.replacingOccurrences(of: "_", with: "\n")
        case 1:
            menu = menus2[indexPath.row].menu
            corner = menus2[indexPath.row].corner.replacingOccurrences(of: "_", with: "\n")
        default:
            print("default")
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: DeviceUtil.knowScreenWidth()/4*3, height: 0))
        label.text = menu
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        let height1 = label.frame.height+15
        label.text = corner
        label.sizeToFit()
        let height2 = label.frame.height+15
        
        if height1 > height2 {
            return CGSize(width: DeviceUtil.knowScreenWidth(), height: height1)
        }
        return CGSize(width: DeviceUtil.knowScreenWidth(), height: height2)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header: UICollectionReusableView? = nil
        
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionIdentifier, for: indexPath) as! MenuSectionView
            
            switch page {
            case 1:
                switch indexPath.section {
                case 0:
                    headerView.titleLabel.text = "복지회관 학생식당"
                    break
                case 1:
                    headerView.titleLabel.text = "카페테리아"
                    break
                default:
                    print("default")
                }
                break
            case 2:
                switch indexPath.section {
                case 0:
                    headerView.titleLabel.text = "사범대식당"
                    headerView.timeLabel2.isHidden = true
                    break
                case 1:
                    headerView.titleLabel.text = "생활관"
                    headerView.timeLabel2.isHidden = false
                    headerView.timeLabel2.text = getTime(headerView.titleLabel.text!, 1)
                    headerView.timeLabel2.sizeToFit()
                    break
                default:
                    print("default")
                }
                break
            case 3:
                switch indexPath.section {
                case 0:
                    headerView.titleLabel.text = "교직원식당"
                    break
                default:
                    print("default")
                }
                break
            default:
                print("")
            }
            headerView.timeLabel.text = getTime(headerView.titleLabel.text!, 0)
            headerView.timeLabel.sizeToFit()
//            headerView.sizeToFit()
            header = headerView
        }
        
        return header!
    }
    
}

extension RestaurantViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

extension RestaurantViewController {
    func getTime(_ name: String, _ type: Int) -> String {
        //매장 별 영업시간
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale.current
        
        let date1:Date = formatter.date(from: "2017-03-02")!
        let date2:Date = formatter.date(from: "2017-06-21")!
        let date3:Date = formatter.date(from: "2017-09-04")!
        let date4:Date = formatter.date(from: "2017-12-22")!
        
//        let today:Date = Date(timeIntervalSinceNow: TimeInterval(TimeZone.current.secondsFromGMT()))
        let today = Date()
        
        if (today > date1 && today < date2) || (today > date3 && today < date4) {
            //학기 중
            switch name {
            case "복지회관 학생식당":
                return "평일 : 10:00 ~ 19:00\n주말 : 휴점"
            case "카페테리아":
                return "평일 : 중식 11:00 ~ 14:00\n         석식 17:00 ~ 19:00\n주말 : 휴점"
            case "사범대식당":
                return "평일 : 중식 11:00 ~ 14:00\n         석식 17:00 ~ 18:30\n주말 : 휴점"
            case "생활관":
                if type == 1 {
                    return "평일 : 조식 07:30 ~ 09:30\n         중식 11:30 ~ 13:30\n         석식 17:00 ~ 19:00"
                } else {
                    return "주말 : 조식 08:00 ~ 10:00\n         중식 12:00 ~ 13:30\n         석식 17:00 ~ 19:00"
                }
            case "교직원식당":
                return "평일 : 중식 11:30 ~ 13:30\n         석식 17:00 ~ 19:00\n주말 : 휴점"
            default:
                return ""
            }
        } else {
            //방학
            switch name {
            case "복지회관 학생식당":
                return "평일 : 08:00 ~ 18:30\n주말 : 08:30 ~ 18:30\n(14:00 ~ 15:00 휴식시간)"
            case "카페테리아":
                return "휴점 (방학)"
            case "사범대식당":
                return "평일 : 중식 11:00 ~ 14:00\n주말 : 휴점"
            case "생활관":
                if type == 1 {
                    return ""
                } else {
                    return "휴점 (방학)"
                }
            case "교직원식당":
                return "평일 : 중식 11:30 ~ 13:30\n         석식 17:00 ~ 18:00\n주말 : 휴점"
            default:
                return ""
            }
        }
    }
}

//import UIKit
//import RxSwift
//import RxCocoa
//import RxDataSources
//import XLPagerTabStrip
//
//struct MySection {
//    var header: String
//    var items: [Item]
//}
//extension MySection : AnimatableSectionModelType {
//    typealias Item = String
//
//    var identity: String {
//        return header
//    }
//
//    init(original: MySection, items: [Item]) {
//        self = original
//        self.items = items
//    }
//}
//
//
//private let reuseIdentifier = "Cell"
//
//class RestaurantViewController: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//
//
//    var itemInfo = IndicatorInfo(title: "View")
//
//    let disposeBag = DisposeBag()
//
//    var dataSource: RxTableViewSectionedAnimatedDataSource<MySection>?
//
//    var svc : [String] = [] //복지회관
//    var cafet : [String] = [] //카페테리아
//    var mch : [String] = [] //사범대
//    var dorm : [String] = [] //기숙사
//    var teach : [String] = [] //교직원
//
//    var tabNum = -1
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//
//        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>()
//
//        dataSource.configureCell = { ds, tv, ip, item in
//            let cell = tv.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
////            cell.textLabel?.text = "Item \(item)"
//            cell.textLabel?.text = item
//
////            let cell = MenuCell(style: .default, reuseIdentifier: reuseIdentifier)
////            cell.corner.text = "1코너"
////            cell.corner.sizeToFit()
////
////            cell.menu.numberOfLines = 0
////            cell.menu.lineBreakMode = .byWordWrapping
////            cell.menu.sizeToFit()
//
//            cell.textLabel?.numberOfLines = 0
//            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//            cell.textLabel?.sizeToFit()
//
//            return cell
//        }
//
//        dataSource.titleForHeaderInSection = { ds, index in
//            return ds.sectionModels[index].header
//        }
//
//        var sections: [MySection] = []
//
//        GetService.fetchMenu(0, Menu.self, success: { response in
////            print(response)
//            //self.boards = response
//
//            for rs in response {
//                //                self.menus.append(rs)
//
//                if rs.menu != "" {
//                    switch rs.name {
//                    case "복지회관":
//                        self.svc.append(rs.corner+" "+rs.menu)
//                    case "카페테리아":
//                        self.cafet.append(rs.corner+" "+rs.menu)
//                    case "사범대식당":
//                        self.mch.append(rs.corner+" "+rs.menu)
//                    case "생활관":
//                        self.dorm.append(rs.corner+" "+rs.menu)
//                    case "교직원":
//                        self.teach.append(rs.corner+" "+rs.menu)
//                    default:
//                        print("default")
//
//                    }
//                }
//            }
//
//            switch self.tabNum {
//            case 0:
////                var sItem = MySection(header: "복지회관 학생식당", items: svc)
////                for item in svc {
////                    sItem.items.append(item)
////                }
////                sections.append(sItem)
////                print(sItem.items)
//                print(self.svc)
//                sections.append(MySection(header: "복지회관 학생식당", items: self.svc))
//                sections.append(MySection(header: "카페테리아", items: self.cafet))
//            case 1:
//                sections.append(MySection(header: "사범대식당", items: self.mch))
//                sections.append(MySection(header: "생활관", items: self.dorm))
//            case 2:
//                sections.append(MySection(header: "교직원식당", items: self.teach))
//            default:
//                print("tab exception")
//            }
//
//            Observable.just(sections)
//                .bindTo(self.tableView.rx.items(dataSource: dataSource))
//                .addDisposableTo(self.disposeBag)
//
//            self.tableView.rx.setDelegate(self)
//                .addDisposableTo(self.disposeBag)
//
//            self.dataSource = dataSource
//
//            self.tableView?.estimatedRowHeight = 100.0
//            self.tableView?.rowHeight = UITableViewAutomaticDimension
//
//            self.tableView?.reloadData()
//        }){ (error) in
//
//        }
//
////        print("menus :",menus)
//
//
////        let sections = [
////            MySection(header: "복지회관 학생식당", items: [
////                1,
////                2
////                ]),
////            MySection(header: "Second section", items: [
////                3,
////                4
////                ])
////        ]
//
//
//    }
//}
//
//
//extension RestaurantViewController : UITableViewDelegate {
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////
////        // you can also fetch item
//////        guard let item = dataSource?[indexPath],
//////            // .. or section and customize what you like
//////            let _ = dataSource?[indexPath.section]
//////            else {
//////                return 0.0
//////        }
////
////        return CGFloat(40)
////    }
//}
//
//extension RestaurantViewController: IndicatorInfoProvider {
//
//    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
//        return itemInfo
//    }
//}

