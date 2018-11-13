//
//  MeHomeTableViewCell.swift
//  swift_Community
//
//  Created by MM on 2018/9/18.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MeHomeTableViewCell: UITableViewCell {
    var titleLabel:UILabel?
    var icon:UIButton?
    var imageLayer:CALayer?
    var name:UILabel?
    var address:UIButton?
    var model:MeModel! {
        didSet{
//            self.icon?.kf.setBackgroundImage(with: URL(string: model.headimg!), for: .normal, placeholder: UIImage(named: "me-touxiang"))
            if ((model.headimg?.count)! > 20){
                self.icon!.kf.setImage(with: URL(string: model.headimg!), for: .normal, placeholder: UIImage.init(named: "me-touxiang"))
            }
            self.name?.text = model.nickName
            if (model.cname == nil || model.cname?.count == 0) {
                self.address?.setTitle("unknown", for: .normal)
            }else{
                self.address?.setTitle(model.cname, for: .normal)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        
        self.contentView.backgroundColor = ThemeColor
        
        self.titleLabel = UILabel.init()
        self.titleLabel?.textColor = UIColor.white
        self.titleLabel?.text = "Me"
        self.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        self.contentView.addSubview(self.titleLabel!)
        
        self.icon = UIButton.init()
        self.icon?.setImage(UIImage.init(named: "me-touxiang"), for: .normal)
        self.icon?.layer.cornerRadius = 35
        self.icon?.clipsToBounds = true
        self.icon?.layer.borderColor = RGB(0, g: 266, b: 221).cgColor
        self.icon?.layer.borderWidth = 2
        self.contentView.addSubview(self.icon!)
        
        self.name = UILabel.init()
        self.name?.textColor = UIColor.white
        self.name?.font = UIFont.systemFont(ofSize: 21)
        self.contentView.addSubview(self.name!)
        
        self.address = UIButton.init()
        self.address?.setTitleColor(UIColor.white, for: .normal)
        self.address?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.address?.setImage(UIImage.init(named: "me-location"), for: .normal)
        self.contentView.addSubview(self.address!)
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self)
            let top = StatusBarHeight
            make.top.equalTo(self.contentView).offset(top)
        })
        
        self.address?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.contentView).offset(-20)
        })
        self.name?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo((self.address?.snp.top)!).offset(-8)
        })
        self.icon?.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 70, height: 70))
            make.centerX.equalTo(self)
            make.bottom.equalTo((self.name?.snp.top)!).offset(-10)
        }
    }
    
    
    
}
