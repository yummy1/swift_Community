//
//  DiscountHeaderView.swift
//  swift_Community
//
//  Created by MM on 2018/11/7.
//  Copyright © 2018年 MM. All rights reserved.
//

import Foundation
import UIKit

class DiscountHeaderView: UIView {
    var categoryBtn:UIButton?
    var latestBtn:UIButton?
    var nearestBtn:UIButton?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        self.backgroundColor = UIColor.groupTableViewBackground
        
        self.categoryBtn = UIButton.init()
        self.categoryBtn?.setTitle("All Category", for: .normal)
        self.categoryBtn?.setTitleColor(ThemeColor, for: .normal)
        self.categoryBtn?.setBackgroundImage(UIImage.from(color: .white), for: .normal)
        self.addSubview(self.categoryBtn!)
        
        self.latestBtn = UIButton.init()
        self.latestBtn?.setTitle("Latest", for: .normal)
        self.latestBtn?.setTitleColor(.black, for: .normal)
        self.latestBtn?.setBackgroundImage(UIImage.from(color: .white), for: .normal)
        self.addSubview(self.latestBtn!)
        
        self.nearestBtn = UIButton.init()
        self.nearestBtn?.setTitle("Nearest", for: .normal)
        self.nearestBtn?.setTitleColor(.black, for: .normal)
        self.nearestBtn?.setBackgroundImage(UIImage.from(color: .white), for: .normal)
        self.addSubview(self.nearestBtn!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.categoryBtn?.snp.makeConstraints({ (make) in
            make.left.top.equalTo(self)
            make.width.equalTo(ScreenWidth*0.4)
            make.bottom.equalTo(self).offset(-1)
        })
        self.latestBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(self)
            make.bottom.equalTo(self).offset(-1)
            make.left.equalTo((self.categoryBtn?.snp_rightMargin)!)
            make.width.equalTo(ScreenWidth*0.3)
        })
        self.nearestBtn?.snp.makeConstraints({ (make) in
            make.right.top.equalTo(self)
            make.bottom.equalTo(self).offset(-1)
            make.left.equalTo((self.latestBtn?.snp_rightMargin)!)
        })
    }
}
extension UIButton{
    override open var isHighlighted: Bool {
        set{
            
        }
        get {
            return false
        }
    }
}
