//
//  MainViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 23..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import RIGImageGallery


private let reuseIdentifier = "MainButtonCell"

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var adView: AdView!
    @IBOutlet weak var adViewHeight: NSLayoutConstraint!
    
    var adLinks = ["\(Network().adURL)/ad1.jpg",
        "\(Network().adURL)/ad2.jpg",
        "\(Network().adURL)/ad3.jpg",
        "\(Network().adURL)/ad4.jpg",
        "\(Network().adURL)/ad5.jpg"]
    var id: String!
    var username: String!
    var department: String!
    var major: String!
    var college: String!
    var status: String!
    
    let keyWindow = UIApplication.shared.keyWindow
    var drawerView = NavigationDrawer(frame: (UIApplication.shared.keyWindow?.frame)!)
    let blackView = UIView()
    let queue = DispatchQueue.global()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("연결됏나")
        
        print("연결안됨")
        self.initView()
        
        queue.async { () -> Void in
            Indicator.startAnimating(activityData)
            self.loadProfile()
            sleep(2)
            
            DispatchQueue.main.async {
                self.initView()
                Indicator.stopAnimating()
            }
        }
        
    }
    
    func initView() {
        
        adView.makePager(imageLinks: adLinks)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        self.collectionView.register(MainButtonCell.self,forCellWithReuseIdentifier: reuseIdentifier)
        drawerView = NavigationDrawer(frame: (keyWindow?.frame)!)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeDrawer))
        self.view.addGestureRecognizer(gesture)
        adViewHeight.constant = AdSize.ad.viewSize
        
        self.adClickable()
    }
    
    func getSession() {
        print("yes")
    }
    
    func loadProfile() {
        UserService.info() { response in
            switch response.result {
                
            case .success(let value):
                print("프로필 정보 받아옴", value)
                self.id = gsno(value.id)
                self.username = gsno(value.username)
                self.department = gsno(value.department)
                self.major = gsno(value.major)
                self.college = gsno(value.college)
                self.status = gsno(value.status)
                
            case .failure(let error):
                print("프로필 정보 받아오기 실패", error)
                
            }
            
        }
    }
    
    func leftSwipable() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(closeDrawer))
        swipeGesture.direction = .left
        self.drawerView.addGestureRecognizer(swipeGesture)
    }
    
    func createDrawer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            keyWindow.addSubview(blackView)
            blackView.frame = keyWindow.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeDrawer)))
            
            keyWindow.addSubview(drawerView)
            drawerView.frame = CGRect(x: 0, y: 0, width: 0, height: keyWindow.frame.height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                self.drawerView.majorLabel.text = gsno(self.major)
                self.drawerView.nameLabel.text = gsno(self.username)
                
                self.drawerView.frame.size.width = DeviceUtil.knowScreenWidth() / 2
                self.drawerView.appInfoButton.addTarget(self, action: #selector(self.appInfoButtonClicked), for: .touchUpInside)
                self.drawerView.logoutButton.addTarget(self, action: #selector(self.logoutButtonClicked), for: .touchUpInside)
            }, completion: { (completedAnimation) in
                //after complete
                self.leftSwipable()
                self.drawerView.showAll()
                
            })
        }
    }
    
    
    func closeDrawer() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.drawerView.frame.size.width = -DeviceUtil.knowScreenWidth() / 2
            self.blackView.alpha = 0
        }, completion: { (completedAnimation) in
            //after complete
            self.drawerView.hideAll()
            
        })
        
    }
    
    @IBAction func leftButtonClicked(_ sender: Any) {
        createDrawer()
    }
    
    func buttonClicked(_ sender: UIButton) {
        print(sender.tag)
        
        if let nvc = buttonType(rawValue: sender.tag)?.connectedView {
            nvc.title = viewType(rawValue: sender.tag)?.viewTitle
            
            self.navigationController?.pushViewController(nvc, animated: true)
        }
        
    }
    
    func adClickable() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(showGallery))
        self.adView.addGestureRecognizer(gesture)
        
    }
    func logoutButtonClicked() {
        
        let queue = DispatchQueue.global()
        queue.async { () -> Void in
            
            PostService.logout() { response in
                switch response.result {
                case .success,
                     .failure where response.response?.statusCode != 409:
                    print("yes")
                    
                    DispatchQueue.main.async {
                        let userDefaults = Foundation.UserDefaults.standard
                        userDefaults.set(false, forKey:"autoLogin")
                        self.closeDrawer()
                        self.dismiss(animated: false, completion: nil)
                    }
                    
                case .failure:
                    print("실패")
                    
                }
            }
            
            
        }
        
    }
    func appInfoButtonClicked() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "appinfoviewcontroller") as! AppInfoViewController
        self.closeDrawer()
        self.present(vc, animated: false, completion: nil)
    }
    
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainButtonCell
        cell.setDefaultImage(idx: indexPath.item)
        //cell.setClicked()
        cell.imageButton.tag = indexPath.item
        cell.imageButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        
        return UIEdgeInsetsMake(30, 20, 20, 20)
        //top,left,bottom,right
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 15.0
    }
    
    // MARK: - UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return MainButtonSize.button.cellSize
    }
    
}

// MARK: - Photo Gallery Library

extension MainViewController {
    func createPhotoGallery() -> RIGImageGalleryViewController {
        
        let urls: [URL] = adLinks.flatMap(URL.init(string:))
        
        let rigItems: [RIGImageGalleryItem] = urls.map { _ in
            RIGImageGalleryItem(placeholderImage: UIImage(named: "placeholder") ?? UIImage(),
                                isLoading: true)
        }
        
        let rigController = RIGImageGalleryViewController(images: rigItems)
        
        for (index, URL) in urls.enumerated() {
            let request = URLSession(configuration: .default).dataTask(with: URLRequest(url: URL)) { [weak rigController] data, _, error in
                if let image = data.flatMap(UIImage.init), error == nil {
                    rigController?.images[index].image = image
                    rigController?.images[index].isLoading = false
                }
            }
            request.resume()
        }
        
        rigController.setCurrentImage(adView.pageControl.currentPage, animated: false)
        
        return rigController
    }
    
    func showGallery() {
        print(adView.pageControl.currentPage)
        let photoViewController = createPhotoGallery()
        photoViewController.dismissHandler = dismissPhotoViewer
        photoViewController.actionButtonHandler = actionButtonHandler
        photoViewController.actionButton = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        photoViewController.traitCollectionChangeHandler = traitCollectionChangeHandler
        photoViewController.countUpdateHandler = updateCount
        let navigationController = UINavigationController(rootViewController: photoViewController)
        //transition
        
        navigationController.modalPresentationStyle = .custom
        navigationController.modalTransitionStyle = .crossDissolve
        
        present(navigationController, animated: true, completion: nil)
    }
    
    func dismissPhotoViewer(_ :RIGImageGalleryViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func actionButtonHandler(_: RIGImageGalleryViewController, galleryItem: RIGImageGalleryItem) {
    }
    
    func updateCount(_ gallery: RIGImageGalleryViewController, position: Int, total: Int) {
        gallery.countLabel.text = "\(position + 1) of \(total)"
    }
    
    func traitCollectionChangeHandler(_ photoView: RIGImageGalleryViewController) {
        let isPhone = UITraitCollection(userInterfaceIdiom: .phone)
        let isCompact = UITraitCollection(verticalSizeClass: .compact)
        let allTraits = UITraitCollection(traitsFrom: [isPhone, isCompact])
        photoView.doneButton = photoView.traitCollection.containsTraits(in: allTraits) ? nil : UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    }
}
