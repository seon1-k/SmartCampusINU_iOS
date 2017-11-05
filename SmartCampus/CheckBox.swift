
//
//  CheckBox.swift
//  smartCampus
//
//  Created by JYNG on 2016. 2. 15..
//  Copyright © 2016년 cho junyng. All rights reserved.
//
import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "1-check")! as UIImage
    let uncheckedImage = UIImage(named: "1-check")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
                self.tintColor = UIColor.blue
            } else {
                self.setImage(uncheckedImage, for: .normal)
                self.tintColor = UIColor.white
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
