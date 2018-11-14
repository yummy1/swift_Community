//
//  DiscountModel.swift
//  swift_Community
//
//  Created by MM on 2018/11/12.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit
import HandyJSON


class DiscountModel: HandyJSON {
    var did : NSInteger?
    var dImage : String?
    var dTitle : String?
    var discount : String?
    var ctime : NSInteger?
    var distance : Int?
    required init() {}
}
class CategorysModel: HandyJSON {
    var cid : String?
    var cTitle : String?
    required init() {}
}
