//
//  CampusMapViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
import GoogleMaps

private let reuseIdentifier = "resultCell"


class CampusMapViewController: UIViewController, GMSMapViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var googleMap: GMSMapView!
    
    var mapData:[MapData] = []
    var mD:[MD] = []
    var filteredA:[MD] = []
    var markers:[GMSMarker] = []
    
    let markerImage:[String] = ["pin01", "pin02", "pin03", "pin04", "pin05", "pin06", "pin07", "pin08", "pin09", "pin10", "pin11", "pin12", "pin13", "pin14", "pin15", "pin16", "pin17", "pin18", "pin19", "pin20", "pin21", "pin22", "pin23", "pin24", "pin25", "pin26", "pin27", "pin28", "pin29", "pin_je_01", "pin_je_02", "pin_je_03", "pin_je_04", "pin_je_05", "pin_je_06", "pin_je_07"]
    
    
    
    var searchBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(searchTapped(_:)))
    
    override func viewDidLoad() {
        //        self.navigationItem.rightBarButtonItem = searchBtn
        //        configureSearchC()
        tableView.isHidden = true
        //        googleMap.isHidden = true
        tableView.delegate = self
        setSearchBar()
        self.setGoogleMap()
        
        
    }
    
    func setSearchBar() {
        searchBar.placeholder = "검색"
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.setValue("취소", forKey: "_cancelButtonText")
        //        searchBar.frame.size.height = 0.0
        //        print(searchBar.frame.height)
        //        searchBar.isHidden = true
        //        searchBar.frame.size.height = 0
        //        self.navigationItem.titleView = searchBar
    }
    
    func setGoogleMap() {
        
        
        googleMap.delegate = self
        let camera = GMSCameraPosition.camera(withLatitude: 37.375789, longitude: 126.633007, zoom: 16.0)
        googleMap.camera = camera
        googleMap.isMyLocationEnabled = true
        
        GetService.fetchMapData(MapData.self, success: { response in
            //            print(response)
            for i in 0...response.count-1 {
                let position = CLLocationCoordinate2D(latitude: response[i].lati, longitude: response[i].longti)
                let marker = GMSMarker(position: position)
                marker.title = response[i].name
                self.mD.append(MD(response[i].name, response[i].longti, response[i].lati, i))
                marker.map = self.googleMap
                marker.icon = UIImage(named: self.markerImage[i])
                
                self.markers.append(marker)
                
            }
            //            print("mD:",self.mD)
            self.filteredA = self.mD
            self.tableView.reloadData()
        }){ (error) in
            
        }
        
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
        //        self.isSearch = true
        self.tableView.isHidden = false
        self.googleMap.isHidden = true
        self.tableView.reloadData()
        //        DispatchQueue.main.async {
        //            self.tableView.reloadData()
        //        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        searchBar.text = ""
        
        //        self.isSearch = false
        self.tableView.isHidden = true
        self.googleMap.isHidden = false
        
        self.filteredA = mD
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        //        self.isSearch = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredA = mD
        } else {
            filteredA = searchText.isEmpty ? mD : mD.filter {
                $0.name.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        //        print(searchText)
        //        print(self.filteredA.count)
        
        if self.tableView.isHidden == false {
            self.tableView.reloadData()
        }
    }
    
    func searchTapped(_ sender:Any){
        UIView.animate(withDuration: 1.0, animations: {
            //            self.searchBar.alpha = 0.0
            self.searchBar.frame.size.height = 0.0
            //            tableView.view.frame.height = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        }, completion: {
            (value: Bool) in
            //do nothing after animation
        })
        
        //        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        ////            view.frame = keyWindow.frame
        ////            self.searchBar.isHidden = false
        //            self.searchBar.frame.size.height = (self.navigationController?.navigationBar.frame.height)!
        //        }, completion: { (completedAnimation) in
        //            //after complete
        //        })
    }
    
    
    //    override func loadView() {
    //        let camera = GMSCameraPosition.camera(withLatitude: 37.375789, longitude: 126.633007, zoom: 16.0)
    //        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    //        mapView.isMyLocationEnabled = true
    ////        mapView.settings.myLocationButton = true
    //        view = mapView
    //
    //        GetService.fetchMapData(MapData.self, success: { response in
    //            print(response)
    //            for i in 0...response.count-1 {
    //                let position = CLLocationCoordinate2D(latitude: response[i].lati, longitude: response[i].longti)
    //                let marker = GMSMarker(position: position)
    //                marker.title = response[i].name
    //                self.nameArr.append(response[i].name)
    //                marker.map = mapView
    //                marker.icon = UIImage(named: self.markerImage[i])
    //            }
    //        }){ (error) in
    //
    //        }
    //
    //    }
}

extension CampusMapViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if self.isSearch == true {
        return filteredA.count
        //        } else {
        //            return nameArr.count
        //            return mD.count
        //        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        //        if self.isSearch {
        cell.textLabel?.text = filteredA[indexPath.row].name
        //        } else {
        //            cell.textLabel?.text = mD[indexPath.row].name
        //        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.filteredA[indexPath.row]
        
        tableView.isHidden = true
        self.googleMap.isHidden = false
        //        self.isSearch = false
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
        self.filteredA = mD
        
        let camera = GMSCameraPosition.camera(withLatitude: data.lati, longitude: data.longti, zoom: 17.0)
        self.googleMap.camera = camera
        self.googleMap.selectedMarker = markers[data.index]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UITableView.self){
            self.searchBar.endEditing(true)
        }
    }
    
    
}

//class CampusMapViewController: UIViewController, UISearchBarDelegate {
//
//    @IBOutlet weak var tableView: UITableView!
//    var isMapShown = false
//    var marker1 = GMSMarker()
//    var marker2 = GMSMarker()
//    var marker3 = GMSMarker()
//    var marker4 = GMSMarker()
//    var marker5 = GMSMarker()
//    var marker6 = GMSMarker()
//    var marker7 = GMSMarker()
//    var marker8 = GMSMarker()
//    var marker9 = GMSMarker()
//    var marker10 = GMSMarker()
//    var marker11 = GMSMarker()
//    var marker12 = GMSMarker()
//    var marker13 = GMSMarker()
//    var marker14 = GMSMarker()
//    var marker15 = GMSMarker()
//    var marker16 = GMSMarker()
//    var marker17 = GMSMarker()
//    var marker18 = GMSMarker()
//    var marker19 = GMSMarker()
//    var marker20 = GMSMarker()
//    var marker21 = GMSMarker()
//    var marker22 = GMSMarker()
//    var marker23 = GMSMarker()
//    var marker24 = GMSMarker()
//    var marker25 = GMSMarker()
//    var marker26 = GMSMarker()
//    var marker27 = GMSMarker()
//    var marker28 = GMSMarker()
//    var marker29 = GMSMarker()
//
//    let food = Observable.just([
//        Food(name: "Kid", flickrID: "TEST"),
//        Food(name: "Kid", flickrID: "TEST"),
//        Food(name: "Kid", flickrID: "TEST"),
//        Food(name: "Kid", flickrID: "TEST")
//    ])
//
//    let searchBar = UISearchBar()
//
//    let disposeBag = DisposeBag()
//
//    var places : [String] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        GetService.fetchMapData()
//
//        food.bindTo(tableView.rx.items(cellIdentifier: reuseIdentifier)) { row, foods, cell in
//
//
//            cell.textLabel?.text = foods.name
//
//            }.addDisposableTo(disposeBag)
//
//
//        createSearchBar()
//        makeRightButton()
//        //createMap()
//
//    }
//
//    func createSearchBar() {
//
//        searchBar.showsCancelButton = false
//        searchBar.placeholder = "검색"
//        searchBar.delegate = self
//
//        self.navigationItem.titleView = searchBar
//    }
//
//    func makeRightButton() {
//
//        let d =  UIBarButtonItem(image: UIImage(named:"map-3"), style: .plain, target: self, action: #selector(toggleView))
//        navigationItem.rightBarButtonItem = d
//
//    }
//    func toggleView() {
//
//        if isMapShown == false {
//            self.tableView.isHidden = true
//
//            isMapShown = true
//        } else {
//            self.tableView.isHidden = false
//
//            isMapShown = false
//        }
//
//    }
//
//}
//extension CampusMapViewController : GMSMapViewDelegate {
//
//    /* 1 ~ 29호관 */
//    func createMap() {
//
//        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 37.375294, longitude: 126.632878, zoom: 16.8)
//
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.isMyLocationEnabled = true
//
//
//        self.view = mapView
//
//
//        marker1.position = CLLocationCoordinate2DMake(37.376765, 126.634663)
//        //marker1.title = "대학본부"
//        marker1.map = mapView
//        marker1.icon = UIImage(named: "pin01")
//
//
//        marker2.position = CLLocationCoordinate2DMake(37.377490, 126.633701)
//        //marker2.title = "교수회관"
//        marker2.map = mapView
//        marker2.icon = UIImage(named: "pin02")
//
//        marker3.position = CLLocationCoordinate2DMake(37.377122, 126.634102)
//        //marker3.title = "홍보관"
//        marker3.map = mapView
//        marker3.icon = UIImage(named: "pin03")
//
//        marker4.position = CLLocationCoordinate2DMake(37.376393, 126.635583)
//        //marker4.title = "정보전산원"
//        marker4.map = mapView
//        marker4.icon = UIImage(named: "pin04")
//
//        marker5.position = CLLocationCoordinate2DMake(37.375493, 126.634913)
//        //marker5.title = "자연과학대학"
//        marker5.map = mapView
//        marker5.icon = UIImage(named: "pin05")
//
//        marker6.position = CLLocationCoordinate2DMake(37.374990, 126.634247)
//        //marker6.title = "도서관"
//        marker6.map = mapView
//        marker6.icon = UIImage(named: "pin06")
//
//        marker7.position = CLLocationCoordinate2DMake(37.374298, 126.633749)
//        //marker7.title = "정보기술대학"
//        marker7.map = mapView
//        marker7.icon = UIImage(named: "pin07")
//
//        marker8.position = CLLocationCoordinate2DMake(37.373347, 126.632981)
//        //marker8.title = "공과대학"
//        marker8.map = mapView
//        marker8.icon = UIImage(named: "pin08")
//
//        marker9.position = CLLocationCoordinate2DMake(37.372640, 126.633432)
//        // marker9.title = "공동실험실습관"
//        marker9.map = mapView
//        marker9.icon = UIImage(named: "pin09")
//
//        marker10.position = CLLocationCoordinate2DMake(37.372806, 126.631796)
//        //marker10.title = "게스트하우스"
//        marker10.map = mapView
//        marker10.icon = UIImage(named: "pin10")
//
//        marker11.position = CLLocationCoordinate2DMake(37.374396, 126.631775)
//        //marker11.title = "복지회관"
//        marker11.map = mapView
//        marker11.icon = UIImage(named: "pin11")
//
//        marker12.position = CLLocationCoordinate2DMake(37.375271, 126.632579)
//        //marker12.title = "컨벤션센터"
//        marker12.map = mapView
//        marker12.icon = UIImage(named: "pin12")
//
//        marker13.position = CLLocationCoordinate2DMake(37.375997, 126.633354)
//        //marker13.title = "사회과학대학/법과대학"
//        marker13.map = mapView
//        marker13.icon = UIImage(named: "pin13")
//
//        marker14.position = CLLocationCoordinate2DMake(37.376456, 126.632818)
//        //marker14.title = "동북아경제통상대학/경영대학/물류대학원"
//        marker14.map = mapView
//        marker14.icon = UIImage(named: "pin14")
//
//        marker15.position = CLLocationCoordinate2DMake(37.375514, 126.631999)
//        //marker15.title = "인문대학/어학원"
//        marker15.map = mapView
//        marker15.icon = UIImage(named: "pin15")
//
//        marker16.position = CLLocationCoordinate2DMake(37.374720, 126.631238)
//        //marker16.title = "예체능대학"
//        marker16.map = mapView
//        marker16.icon = UIImage(named: "pin16")
//
//        marker17.position = CLLocationCoordinate2DMake(37.374063, 126.630793)
//        //marker17.title = "학생회관"
//        marker17.map = mapView
//        marker17.icon = UIImage(named: "pin17")
//
//        marker18.position = CLLocationCoordinate2DMake(37.373740, 126.629811)
//        //marker18.title = "기숙사"
//        marker18.map = mapView
//        marker18.icon = UIImage(named: "pin18")
//
//        marker19.position = CLLocationCoordinate2DMake(37.374567, 126.630251)
//        //marker19.title = "국제교류관"
//        marker19.map = mapView
//        marker19.icon = UIImage(named: "pin19")
//
//        marker20.position = CLLocationCoordinate2DMake(37.374891, 126.629661)
//        //marker20.title = "스포츠센터"
//        marker20.map = mapView
//        marker20.icon = UIImage(named: "pin20")
//
//        //marker21.title = "체육관"
//        marker21.map = mapView
//        marker21.icon = UIImage(named: "pin21")
//        marker21.position = CLLocationCoordinate2DMake(37.375458, 126.630251)
//
//        marker22.position = CLLocationCoordinate2DMake(37.375842, 126.630771)
//        //marker22.title = "학군단"
//        marker22.map = mapView
//        marker22.icon = UIImage(named: "pin22")
//
//        marker23.position = CLLocationCoordinate2DMake(37.377813, 126.632449)
//        //marker23.title = "공연장"
//        marker23.map = mapView
//        marker23.icon = UIImage(named: "pin23")
//
//        marker24.position = CLLocationCoordinate2DMake(37.375932, 126.635739)
//        //marker24.title = "전망타워"
//        marker24.map = mapView
//        marker24.icon = UIImage(named: "pin24")
//
//        marker25.position = CLLocationCoordinate2DMake(37.375152, 126.635991)
//        //marker25.title = "어린이집"
//        marker25.map = mapView
//        marker25.icon = UIImage(named: "pin25")
//
//        marker26.position = CLLocationCoordinate2DMake(37.375195, 126.635567)
//        //marker26.title = "온실"
//        marker26.map = mapView
//        marker26.icon = UIImage(named: "pin26")
//
//        marker27.position = CLLocationCoordinate2DMake(37.371911, 126.633255)
//        //marker27.title = "제2공동실험실습관"
//        marker27.map = mapView
//        marker27.icon = UIImage(named: "pin27")
//
//        marker28.position = CLLocationCoordinate2DMake(37.372806, 126.631796)
//        //marker28.title = "도시과학대학"
//        marker28.map = mapView
//        marker28.icon = UIImage(named: "pin28")
//
//        marker29.position = CLLocationCoordinate2DMake(37.372094, 126.632686)
//        //marker29.title = "생명공학부"
//        marker29.map = mapView
//        marker29.icon = UIImage(named: "pin29")
//
//        mapView.delegate = self
//    }
//}
