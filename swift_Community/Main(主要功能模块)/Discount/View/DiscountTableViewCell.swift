//
//  DiscountTableViewCell.swift
//  swift_Community
//
//  Created by MM on 2018/10/24.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit

class DiscountTableViewCell: UITableViewCell {

    @IBOutlet weak var discountNum: UILabel!
    @IBOutlet weak var shopDistance: UILabel!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var icon: UIImageView!
    var model : DiscountModel!{
        didSet{
            self.icon.kf.setImage(with: URL(string: (self.model?.dImage!)!), placeholder: UIImage(named: "thumbImage"))
            self.shopName.text = model.dTitle
            let dis:Float = Float(model.distance!)/1000.00
            self.shopDistance.text = String(format: "%.2fkm", dis)
            self.discountNum.text = model.discount
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    
}
