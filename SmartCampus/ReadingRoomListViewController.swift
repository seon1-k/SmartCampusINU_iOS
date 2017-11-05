//
//  NoticeViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 26..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ReadingRoomCell"

class ReadingRoomListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var readingRooms : [ReadingRoom] = []
    let queue = DispatchQueue.global()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queue.async { () -> Void in
            Indicator.startAnimating(loadIndicatorData)
            
            GetService.fetchReadingRoom(requesturl: "") { response in
                
                self.readingRooms = response
                print(response)
                
                
                
            }
            //sleep(2)
            
            DispatchQueue.main.async {
                self.initView()
                self.tableView.reloadData()
                Indicator.stopAnimating()
            }
        }

    }
    func initView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.bounces = false
        
        tableView.register(UINib(nibName: "ReadRoomViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
}
extension ReadingRoomListViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "readingroomviewcontroller") as! ReadingRoomViewController
        vc.requestURL = readingRooms[indexPath.item].link
        vc.title = readingRooms[indexPath.item].room

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ReadRoomViewCell
        
        cell.roomLabel?.text = readingRooms[indexPath.item].room
        cell.userLabel?.text = readingRooms[indexPath.item].room
        cell.rateLabel?.text = readingRooms[indexPath.item].rate
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! ReadRoomViewCell
        headerCell.rateLabel.textColor = UIColor.white
        headerCell.roomLabel.textColor = UIColor.white
        headerCell.userLabel.textColor = UIColor.white
        headerCell.backgroundColor = UIColor(red: 102/255, green: 153/255, blue: 102/255, alpha: 1)
        
        return headerCell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
    
}
