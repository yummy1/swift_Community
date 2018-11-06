//
//  MainTabViewController.swift
//  swift_Community
//
//  Created by MM on 2018/9/4.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    let homeVC = HomeViewController();
    let menjinVC = HomeViewController();
    let discountVC = DiscountViewController();
    let meVC = MeViewController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.addChildViewController(childVc: homeVC, itemTitle: "首页", normalImage: UIImage.init(named: "Home")!, selectedImage: UIImage.init(named: "Home-act")!)
        self.addChildViewController(childVc: menjinVC, itemTitle: "门禁", normalImage: UIImage.init(named: "Door")!, selectedImage: UIImage.init(named: "Door-act")!)
        self.addChildViewController(childVc: discountVC, itemTitle: "优惠", normalImage: UIImage.init(named: "Discount")!, selectedImage: UIImage.init(named: "Discount-act")!)
        self.addChildViewController(childVc: meVC, itemTitle: "我的", normalImage: UIImage.init(named: "me")!, selectedImage: UIImage.init(named: "me-act")!)
        
    }

    private func addChildViewController(childVc:UIViewController,itemTitle:String,normalImage:UIImage,selectedImage:UIImage) {
        childVc.view.backgroundColor = UIColor.white
        childVc.title = itemTitle
        childVc.tabBarItem.image = normalImage;
        childVc.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal);
        // 选中状态的文字的字体属性
        let selectedTextAttr:NSMutableDictionary = NSMutableDictionary.init()
        selectedTextAttr["NSForegroundColorAttributeName"] = ThemeColor
        // 正常状态下的文字字体属性
        let normalTextAttr:NSMutableDictionary = NSMutableDictionary.init()
        // 设置tabbarItem字体属性
        childVc.tabBarItem.setTitleTextAttributes(selectedTextAttr as? [NSAttributedStringKey : Any], for: .selected)
        childVc.tabBarItem.setTitleTextAttributes(normalTextAttr as? [NSAttributedStringKey : Any], for: .normal)
        
        self.addChildViewController(MainNavigationController.init(rootViewController:childVc))
        
    }
    

    

}
