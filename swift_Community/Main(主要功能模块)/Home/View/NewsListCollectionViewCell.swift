//
//  NewsListCollectionViewCell.swift
//  swift_Community
//
//  Created by MM on 2018/9/14.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit
import Kingfisher

class NewsListCollectionViewCell: UICollectionViewCell {
    
    var model:NewModel?{
        didSet{
            self.icon.kf.setImage(with: URL(string: (self.model?.nImage!)!), placeholder: UIImage(named: "thumbImage"))
            self.titleLabel.text = self.model?.nTitle
            self.commentNum.text = self.model?.nMsg
            self.likeNum.text = self.model?.nLike
            self.dateLabel.text = self.model?.nDate?.components(separatedBy: " ")[0]
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var commentNum: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
}
