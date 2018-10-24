//
//  MMGlobalProperty.swift
//  swift_Community
//
//  Created by MM on 2018/9/4.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit
// MARK: -- 屏幕属性

/// 屏幕宽度
let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width

/// 屏幕高度
let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height

/// iPhone X、iPhone Xs、iPhone XR、iPhone Xs MAX
let isFullScreen:Bool = ((ScreenHeight == CGFloat(812) && ScreenWidth == CGFloat(375)) || (ScreenHeight == CGFloat(896) && ScreenWidth == CGFloat(414)))

/// 导航栏高度
let NavgationBarHeight:CGFloat = isFullScreen ? 88 : 64

/// TabBar高度
let TabBarHeight:CGFloat = isFullScreen ? 83 : 49

/// iPhone X 顶部刘海高度
let TopLiuHeight:CGFloat = 30

/// StatusBar高度
let StatusBarHeight:CGFloat = isFullScreen ? 44 : 20

// MARK: -- 颜色支持
let ThemeColor = RGB(25, g: 147, b: 252)

// MARK: -- URL
let baseUrl = "http://149.28.161.39:8080/"
//注册、个人
let mHttpUser = baseUrl + "smart.do?apiUser"
//首页
let mHttpHome = baseUrl + "smart.do?apiFistPage"
//开门、优惠、上传图片
let mHttpImage = baseUrl + "smart.do?OtherAPI"












