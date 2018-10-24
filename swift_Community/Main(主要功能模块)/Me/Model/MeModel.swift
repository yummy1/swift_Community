//
//  MeModel.swift
//  swift_Community
//
//  Created by MM on 2018/9/18.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit
import Foundation
import HandyJSON

public enum ROLETYPE:Int,HandyJSONEnum {
    case ROLETYPE_ZH = 1
    case ROLETYPE_FK = 0
}
class MeModel: HandyJSON {
    var uid : String?
    var imei : String?
    var nickName : String?
    var realName : String?
    var headimg : String?
    var gender : String?
    var cid : String?
    var cname : String?
    var hid : String?
    var ispush : String?
    var roleType : ROLETYPE?
    required init() {}
}

class SettingsModel: HandyJSON {
    var icon:String?
    var title:String?
    required init() {}
}














