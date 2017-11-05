//
//  AcademyViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import JTAppleCalendar
import XLPagerTabStrip

class AcademyViewController: UIViewController, UIScrollViewDelegate {
    
    
    internal var dates: [NSDate?]!

    //캘린더
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    //월
    @IBOutlet weak var monthLabel: UILabel!
    
    //높이 고정
    @IBOutlet weak var calendarViewHeight: NSLayoutConstraint!
    
    //텍스트 뷰
    @IBOutlet weak var TextView: UITextView!
    

    var testCalendar = Calendar.current
    var page:Int = -1

    var itemInfo = IndicatorInfo(title: "View")
    let red = UIColor.red
    
    let white = UIColor.black
    let darkPurple = UIColor.darkGray
    let dimPurple = UIColor.gray
    
    var dateStr : String?
    
    var academic_content: String = ""
    var firstDate : String?
    var endDate : String?
    
    var haksa = [Haksa]()
    
    
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(haksa)
       
        calendarView.visibleDates(){
            visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
            
        }
        
        
        
       
        
        //        //학사일정 불러오기
        //        GetService.fetchHaksa(Haksa.self, success: { response in
        //            print(response)
        //            for rs in response {
        //                self.haksa.append(rs)
        //
        //                let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "academyviewcontroller") as! AcademyViewController
        //
        //                let f_date = rs.first_date
        //                let e_date = rs.last_date
        //                let content = rs.academic_content
        //
        //                vc.firstDate = f_date
        //                vc.endDate = gsno(e_date)
        //                vc.academic_content = gsno(content)
        ////                print("****\(vc.academic_content)")
        //
        //                //달 별로 데이터 보내주기
        //                if let comp = vc.firstDate?.components(separatedBy: "-"){
        //                    switch comp[1]{
        //
        //                    case "01":
        //
        //                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        //                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate)) : "))
        //                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        //                        print("01월 : \(vc.academic_content)")
        //                        print("01월 : \(self.itemInfo.title)")
        //
        //                        break
        //
        //
        //                    case "02":
        //                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        //                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate)) : "))
        //                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        //                        print("02월 : \(vc.academic_content)")
        //                        break
        ////
        ////                    case "03":
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate))"))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("03월 : \(vc.academic_content)")
        ////                    case "04":
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate))"))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("04월 : \(vc.academic_content)")
        ////                    case "05":
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate))"))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("05월 : \(vc.academic_content)")
        ////                    case "06":
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate))"))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("06월 : \(vc.academic_content)")
        ////                    case "07":
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate))"))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("07월 : \(vc.academic_content)")
        ////                    case "08":
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate))"))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("08월 : \(vc.academic_content)")
        ////                    case "09":
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate))"))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("09월 : \(vc.academic_content)")
        ////                    case "10":
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate))"))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("10월 : \(vc.academic_content)")
        ////                    case "11":
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate))"))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("11월 : \(vc.academic_content)")
        ////                    case "12":
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate))"))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("12월 : \(vc.academic_content)")
        //
        //                    default:
        //                        break
        //
        //                    }
        //
        //                }
        ////
        //////
        ////                let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "academyviewcontroller") as! AcademyViewController
        ////
        ////                if let comp = vc.firstDate?.components(separatedBy: "-"){
        ////                    switch comp[1]{
        ////
        ////                    case "01":
        ////
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate)) : "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("01월 : \(vc.academic_content)")
        ////                        //                            print("01월 : \(self.TextView.text)")
        ////                        break
        ////
        ////
        ////                    case "02":
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate)) : "))
        ////                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
        ////                        print("02월 : \(vc.academic_content)")
        ////                        break
        ////                        
        ////                    default:
        ////                        break
        ////                        
        ////                    }
        ////                    
        ////                }
        ////                
        ////           
        //                
        //                
        //               
        //               
        //    
        //                
        //                self.calendarView.reloadData()
        //                
        //            }
        //            
        //        }){ (error) in
        //            
        //        }
        //   
        //    

   
    
        
      
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "DateView") // Registering your cell is manditory
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        
        
        initView()
        getHaksa()
    }
    
    func getHaksa(){
        GetService.fetchHaksa(Haksa.self, success: { response in
            //                    print(response)
            for rs in response {
              
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
              
                let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "academyviewcontroller") as! AcademyViewController
                
                                let f_date = rs.first_date
                                let e_date = rs.last_date
                                let content = rs.academic_content
                
                                vc.firstDate = f_date
                                vc.endDate = gsno(e_date)
                                vc.academic_content = gsno(content)
                
                let fd:Date = dateFormatter.date(from: rs.first_date)!
                let ld:Date = dateFormatter.date(from: rs.last_date)!
                let calendar = Calendar.current
                let first_year:Int = calendar.component(.year, from: fd)
                let first_month:Int = calendar.component(.month, from: fd)
                let last_year:Int = calendar.component(.year, from: fd)
                let last_month:Int = calendar.component(.month, from: ld)
                //                        print(fd)
                //                        print(first_month)
                //                        print(ld)
                //                        print(last_month)
                
                //각 데이터를 쪼개어 배열에 삽입.
                //시작일이 1월, 종료일이 2월이라면 january, febuary 두 배열에 모두 삽입됨
                //                        print()
                let this_year = calendar.component(.year, from: Date())
                if first_year == this_year {
                    //시작날짜의 해가 올해일 경우에만 배열에 삽입
                    if self.page == first_month {
                        self.haksa.append(rs)
                                                self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
                                                self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate)) : "))
                                                self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
                                                print(" : \(vc.academic_content)")
                    }
                }
                if last_year == this_year {
                    if self.page == last_month {
//                        self.haksa.append(rs)
//                        self.TextView.textStorage.append(NSAttributedString(string: "\(gsno(vc.firstDate)) "))
//                        self.TextView.textStorage.append(NSAttributedString(string: "~ \(gsno(vc.endDate)) : "))
//                        self.TextView.textStorage.append(NSAttributedString(string: "\(vc.academic_content) \n"))
//                        print(" : \(vc.academic_content)")
                    }
                }
            }
            
            
            self.calendarView.reloadData()
            print(self.haksa)
        }) { (error) in
            
        }
    }
    
    
    func initView() {
        
        self.calendarViewHeight.constant = DeviceUtil.knowScreenWidth() - 80
        self.view.layer.borderWidth = 10
        self.view.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    @IBAction func previous(_ sender: Any) {
        self.calendarView.scrollToSegment(.previous) {
            self.calendarView.visibleDates({ (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            })
        }
        
    }
    
    @IBAction func next(_ sender: Any) {
        self.calendarView.scrollToSegment(.next) {
            self.calendarView.visibleDates({ (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            })
        }
    }
    
    
    //monthLable 구동 부분
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {

     
        let date = visibleDates.monthDates.first!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        self.monthLabel.text = formatter.string(from: date)
        
        
        
//    guard let startDate = visibleDates.monthDates.first else {
//            return
//        }
//        let month = testCalendar.dateComponents([.month], from: startDate).month!
//        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
//        // 0 indexed array
//        let year = testCalendar.component(.year, from: startDate)
//        
//        monthLabel.text = monthName + " " + String(year)
//        
//       
        
        

    }
    
    
}

extension AcademyViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    
    
    
    //달력생성
    //월 누를때마다 각 월에 1일을 반환한다.
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
//        print("date str : ",gsno(dateStr))
       
        print("<<<<<date str: ", gsno(dateStr))
        
        let startDate = formatter.date(from: gsno(dateStr))! // You can use date generated from a formatter
        // endDate 뭔지모르겠지만 이것때문에 에러발생 해서 start == end 맞춰놈
        let endDate = formatter.date(from: gsno(dateStr))!                                // You can also use dates created from this function
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            
            
            
        
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .sunday)
        
        
        
        return parameters
    }
   
    
    //일 dateview
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        
        let myCustomCell = cell as! DateView
        

      

        //현재 날 표시
            myCustomCell.dayLabel.text = cellState.text
       
        if testCalendar.isDateInToday(date) {
            let size:CGFloat = 35.0 // 35.0 chosen arbitrarily
            
            myCustomCell.bounds = CGRect(x:0.0, y:0.0, width:size, height: size)
            myCustomCell.layer.cornerRadius = size / 2
            myCustomCell.backgroundColor = red

            
         } else {
            myCustomCell.backgroundColor = UIColor.clear
        }
        
        
        handleCellTextColor(view: myCustomCell, cellState: cellState)
        handleCellSelection(view: myCustomCell, cellState: cellState)
        

    }
    
    // select date
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
       
      
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        
       

        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
 
    
    
    // 셀 텍스트 다루는 부분
    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
        
        guard let myCustomCell = view as? DateView  else {
            return
        }
        
        
     if cellState.isSelected {
            myCustomCell.dayLabel.textColor = darkPurple
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                myCustomCell.dayLabel.textColor = white
            } else {
                myCustomCell.dayLabel.textColor = dimPurple
            }
        }
    }
    // Function to handle the calendar selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? DateView  else {
            return
        }
        

        if cellState.isSelected {
            myCustomCell.selectedView.layer.cornerRadius = 25;
            myCustomCell.selectedView.isHidden = false
        } else {
            myCustomCell.selectedView.isHidden = true
        }
    }
    
}
extension AcademyViewController{
   

}

extension AcademyViewController: IndicatorInfoProvider {
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

