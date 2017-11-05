//
//  BoardListViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 29..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip

private let reuseIdentifier = "Cell"

class BoardListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var itemInfo = IndicatorInfo(title: "View")
    
    let queue = DispatchQueue.global()
    var refreshControl = UIRefreshControl()
    var boards : [Board] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: "BoardViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        queue.async { () -> Void in
            Indicator.startAnimating(loadIndicatorData)
            
            self.getBoards()
            
            DispatchQueue.main.async {
                
                self.collectionView?.reloadData()
                Indicator.stopAnimating()
                self.addRefreshControl()
            }
        }
    }
    
    @IBAction func showPostView(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "postboardviewcontroller") as! PostBoardViewController
        
        vc.title = "글쓰기"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getBoards() {
        self.boards = []
        GetService.fetchBoardList(Board.self, success: { response in
            print(response)
            //self.boards = response
            
            for rs in response {
                rs.date = DateUtil.convertDateString(dateString: rs.date, fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormat: "yyyy-MM-dd")
                self.boards.append(rs)
            }
            self.collectionView.reloadData()
        }){ (error) in
            
        }
    }
    
    func addRefreshControl() {
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(NoticeListViewController.refresh), for: UIControlEvents.valueChanged)
        self.collectionView?.addSubview(self.refreshControl)
    }
    func refresh() {
        if (self.refreshControl.endRefreshing() != nil) {
            
            OperationQueue.main.addOperation({ () -> Void in
         
                self.getBoards()
                
            })
            
        }
    }
    
}
extension BoardListViewController :UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BoardViewCell
        
        cell.boardTitleLabel.text = "■  게시판"
        cell.titleLabel?.text = boards[indexPath.item].title
        cell.writerLabel?.text = boards[indexPath.item].writer
        cell.dateLabel?.text = boards[indexPath.item].date
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        
        return UIEdgeInsetsMake(10, 0, 10, 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 10
    }
    
    // MARK: - UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: DeviceUtil.knowScreenWidth() - 20, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "boardviewcontroller") as! BoardViewController
        
        vc.contentTitleText = boards[indexPath.item].title
        vc.writerText = boards[indexPath.item].writer
        vc.dateText = boards[indexPath.item].date
        vc.boardId = boards[indexPath.item].id
        vc.title = "게시판"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension BoardListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

