//
//  HomeModel.swift
//  swift_Community
//
//  Created by MM on 2018/9/12.
//  Copyright © 2018年 MM. All rights reserved.
//

import Foundation
import UIKit
import HandyJSON

class HomeModel: HandyJSON {
    var cName : String?
    var cid : String?
    var room : String?
    var unit : String?
    var building : String?
    var hid : String?
    var adImages : String?
    var uIdentity : Int?
    var news : [NewModel]?
    required init() {}
}
class NewModel: HandyJSON {
    var nid : String?
    var nImage : String?
    var nTitle : String?
    var nDate : String?
    var nLike : String?
    var nMsg : String?
    required init() {}
}
