//
//  IntExtension.swift
//  swift_Community
//
//  Created by MM on 2018/11/7.
//  Copyright © 2018年 MM. All rights reserved.
//

import Foundation
extension Int {
    //前+
    static prefix  func ++(num:inout Int) -> Int  {
        num += 1
        return num
    }
    //后缀+
    static postfix  func ++(num:inout Int) -> Int  {
        let temp = num
        num += 1
        return temp
    }
    //前 -
    static prefix  func --(num:inout Int) -> Int  {
        num -= 1
        return num
    }
    //后-
    static postfix  func --(num:inout Int) -> Int  {
        let temp = num
        num -= 1
        return temp
    }
}

