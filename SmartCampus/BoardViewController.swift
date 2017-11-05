//
//  BoardViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 4. 27..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CommentCell"

class BoardViewController: UIViewController {
    
    @IBOutlet weak var boardTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentView: UITextView!
    @IBOutlet weak var commentListView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postCommentButton: UIButton!
    
    var boardTitleText = ""
    var contentTitleText = ""
    var writerText = ""
    var dateText = ""
    var boardId = 0
    
    var comments = [BoardComment]()
    
    var kbHeight : CGFloat?
    var animated: Bool = false
    var keyboardIsShown : Bool = false
    
    let userDefaults = Foundation.UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = contentTitleText
        writerLabel.text = writerText
        dateLabel.text = dateText
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextField.delegate = self
        
        commentListView.delegate = self
        commentListView.dataSource = self
        commentListView.register(UINib(nibName: "CommentViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        self.commentListView.tableFooterView = UIView()
        self.commentListView.rowHeight = UITableViewAutomaticDimension
        self.commentListView.estimatedRowHeight = 70.0
        
        self.getContents()
        self.getComments()
        
        self.commentTextField.layer.borderWidth = 0.5
        self.commentTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.postCommentButton.layer.borderWidth = 0.5
        self.postCommentButton.layer.borderColor = UIColor.lightGray.cgColor
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(gesture)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(BoardViewController.keyboardWillShow(notification:)),
            name: .UIKeyboardWillShow,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(BoardViewController.keyboardWillHide(sender:)),
            name: .UIKeyboardWillHide,
            object: nil)
        
        
    }
    func getContents() {
        
        GetService.fetchBoardContent(self.boardId) { response in
            switch response.result {
                
            case .success(let value):
                self.contentView.text = value.content
                
            case .failure(let error):
                print("정보 받아오지 못함", error)
                
            }
            
        }
    }
    
    
    func getComments() {
        
        self.comments = []
        
        GetService.fetchCommentList(self.boardId, BoardComment.self, success: { response in
            
            
            for rs in response {
                rs.date = DateUtil.convertDateString(dateString: rs.date, fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormat: "yyyy-MM-dd")
                self.comments.append(rs)
                print(rs.content)
            }
            
            
            self.commentListView.reloadData()
            
        }){ (error) in
            
        }
        
        
    }
    
    func reloadComments() {
        self.getComments()
        self.commentTextField.resignFirstResponder()
        self.commentTextField.text = ""
    }
    
    @IBAction func writeComment(_ sender: Any) {
        
        
        guard let commentText = self.commentTextField.text, (self.commentTextField.text?.characters.count)! > 0 else { return }
        
        let queue = DispatchQueue.global()
        
        
        queue.async { () -> Void in
            
            PostService.writeComment(stuid: gsno(self.userDefaults.string(forKey: "stuid")), b_id: self.boardId, date: DateUtil.getCurrentTime(), content: commentText) { response in
                switch response.result {
                case .success,
                     .failure where response.response?.statusCode != 409:
                    print("성공")
                    
                    self.reloadComments()
                    
                case .failure:
                    print("실패")
                    
                }
            }
            
            DispatchQueue.main.async {
                self.commentListView.reloadData()
                self.commentListView.tableViewScrollToBottom(animated: true)
                
                
            }
        }
        
        
    }
    
    func hideKeyboard() {
        commentTextField.resignFirstResponder()
    }
    // keyboard noti
    func keyboardWillShow(notification:NSNotification) {
        print("Shown")
        
        if self.keyboardIsShown == false {
            if let userInfo = notification.userInfo {
                if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                    kbHeight = keyboardSize.height
                    self.animateTextField(up: true)
                }
            }
        }
        self.keyboardIsShown = true
        
    }
    func keyboardWillHide(sender: NSNotification) {
        if self.keyboardIsShown == true {
            self.animateTextField(up: false)
        }
        self.keyboardIsShown = false
    }
    
    func animateTextField(up: Bool) {
        
        let movement = (up ? -kbHeight! : kbHeight)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement!)
            self.animated = true
            
        })
        
    }
    
}
extension BoardViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.commentTextField!.resignFirstResponder()
        return true
    }
}

extension BoardViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentListView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CommentViewCell
        
        cell.writerLabel.text = comments[indexPath.item].stu_id
        cell.dateLabel.text = comments[indexPath.item].date
        cell.commentLabel.text = comments[indexPath.item].content
        
        return cell
    }
}
extension UITableView {
    
    func tableViewScrollToBottom(animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: animated)
            }
        }
    }
}
