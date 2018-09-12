//
//  MainNavigationController.swift
//  swift_Community
//
//  Created by MM on 2018/9/4.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // 取出导航条
        let navBar = UINavigationBar.appearance()
        // 1.1、设置背景图片
        let image = UIImage.from(color: ThemeColor)
        navBar.setBackgroundImage(image, for: .default)
        // 1.2、设置字体属性
        let navBarattrs = NSMutableDictionary.init()
        navBarattrs[NSAttributedStringKey.foregroundColor] = UIColor.white
        navBarattrs[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 20)
        navBar.titleTextAttributes = navBarattrs as? [NSAttributedStringKey : Any]
        // 1.3、设置返回箭头的颜色
        navBar.tintColor = UIColor.white
        navBar.barTintColor = UIColor.white
        // 1.4 去掉返回按钮的字
        if #available(iOS 11.0, *) {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.clear], for: .normal)
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.clear], for: .highlighted)
        }else{
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for: .default)
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated);
    }
}
