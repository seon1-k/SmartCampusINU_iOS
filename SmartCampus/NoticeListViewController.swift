//
//  NoticeViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 26..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import RxCocoa

private let reuseIdentifier = "NoticeViewCell"

class NoticeListViewController: UICollectionViewController {
    var boardId : String?
    
    var itemInfo = IndicatorInfo(title: "View")
    
    var disposeBag = DisposeBag()
    var notices : [Notice] = []
    let queue = DispatchQueue.global()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notices = []
        
        queue.async { () -> Void in
            Indicator.startAnimating(loadIndicatorData)
            
            GetService.fetchNotices(requesturl: Network().noticeURL, boardid: self.boardId!) { response in
                
                self.notices = response
                
            }

            DispatchQueue.main.async {
                self.initView()
                self.collectionView?.reloadData()
                Indicator.stopAnimating()
                
            }
        }
        
    }
    
    func initView() {
        self.collectionView?.backgroundColor = UIColor.init(netHex: 0xf6f6f6)
        collectionView!.dataSource = nil
        
        let items1 = Observable.just(notices)
        
        self.collectionView?.register(UINib(nibName: "NoticeViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        
        let itemSize = CGSize(width: DeviceUtil.knowScreenWidth() - 20, height: 60)
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = itemSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        items1.bindTo(collectionView!.rx.items(cellIdentifier: reuseIdentifier, cellType: NoticeViewCell.self))
        { (row: Int, game: Notice, cell: NoticeViewCell) in
            cell.titleLabel?.text = self.notices[row].title
            cell.writerLabel?.text = self.notices[row].writer
            cell.dateLabel?.text = self.notices[row].date
            
            }
            .addDisposableTo(disposeBag)
        
        collectionView!.rx
            .modelSelected(Notice.self)
            .subscribe(onNext:  { notice in
                
                
                let vc = UIStoryboard(name: "Page", bundle: nil).instantiateViewController(withIdentifier: "noticeviewcontroller") as! NoticeViewController
                
                vc.requestURL = notice.link
                
                self.present(vc, animated: false)
                
                
            })
            .addDisposableTo(disposeBag)
        self.addRefreshControl()
    }
    
    
    func addRefreshControl() {
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(NoticeListViewController.refresh), for: UIControlEvents.valueChanged)
        self.collectionView?.addSubview(self.refreshControl)
    }
    func refresh() {
        if (self.refreshControl.endRefreshing() != nil) {
            
            self.notices = []
            
            OperationQueue.main.addOperation({ () -> Void in
                GetService.fetchNotices(requesturl: Network().noticeURL, boardid: self.boardId!) { response in
                    
                    self.notices = response
                }
            })
            
            self.collectionView?.reloadData()
        }
    }
    
    
}
extension NoticeListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}


