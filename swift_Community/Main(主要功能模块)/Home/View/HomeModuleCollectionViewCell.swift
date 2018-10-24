//
//  HomeModuleCollectionViewCell.swift
//  swift_Community
//
//  Created by MM on 2018/9/14.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit

class HomeModuleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBAction func clickAction(_ sender: UIButton) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor.clear
        
        self.bgView.layer.cornerRadius = 10
        self.bgView.layer.masksToBounds = true
        
        
//        self.contentView.layer.shadowColor = RGB(150, g: 150, b: 150).cgColor
//        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.contentView.layer.shadowOpacity = 0.5
//        self.contentView.layer.shadowRadius = 3
//        self.contentView.layer.masksToBounds = false
        
        
        self.layer.shadowPath = UIBezierPath.init(rect: self.bounds).cgPath
        self.layer.shadowColor = RGB(150, g: 150, b: 150).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 50, height: 20)
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
        
    }
    func addShadow(shadowOpacity:Float, shadowColor:UIColor, radius:CGFloat)  {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3
        self.layer.cornerRadius = radius
        //        self.layer.masksToBounds = true  // 不能使用 不然阴影会被裁剪
    }
}
