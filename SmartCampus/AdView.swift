//
//  AdView.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 24..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import Kingfisher

@IBDesignable class AdView: UIView, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var adLinks = ["\(Network().adURL)/ad1.jpg",
        "\(Network().adURL)/ad2.jpg",
        "\(Network().adURL)/ad3.jpg",
        "\(Network().adURL)/ad4.jpg",
        "\(Network().adURL)/ad5.jpg"]
    
    let nibName = "AdView"
    var view : UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetUp()
        
        //makePager()
        
    }
    // Story board init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetUp()
        
    }
    
    func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func makePager(imageLinks:[String]) {
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = imageLinks.count
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        self.scrollView.isPagingEnabled = true
        self.scrollView.contentSize = CGSize(width: DeviceUtil.knowScreenWidth() * 5, height: AdSize.ad.viewSize)
        var index = 0
        
        for link in imageLinks {
            
            let startX: CGFloat = CGFloat(index) * DeviceUtil.knowScreenWidth()
            
            let imageView = UIImageView(frame: CGRect(x: startX, y: 0, width: DeviceUtil.knowScreenWidth(), height: AdSize.ad.viewSize))
            imageView.contentMode = .scaleAspectFit
            scrollView.sizeToFit()
            imageView.kf.setImage(with: URL(string: link))
            
            scrollView!.addSubview(imageView)
            index = index + 1
        }
        
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("tete")
        let page:Int = Int(floor(scrollView.contentOffset.x / UIScreen.main.bounds.size.width))
        
        self.pageControl!.currentPage = page
        
    }

}
