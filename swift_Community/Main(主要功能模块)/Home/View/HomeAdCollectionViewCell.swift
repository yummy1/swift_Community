//
//  HomeAdCollectionViewCell.swift
//  swift_Community
//
//  Created by MM on 2018/9/12.
//  Copyright © 2018年 MM. All rights reserved.
//


import UIKit
import LLCycleScrollView

class HomeAdCollectionViewCell:UICollectionViewCell  {
    var bannerDemo : LLCycleScrollView!
    var ads : String!{
        didSet{
            // 模拟网络图片获取
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                self.bannerDemo.imagePaths = self.ads.components(separatedBy: ",")
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bannerDemo.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth/1.84+StatusBarHeight)
    }
    func setupUI(){
        
        self.bannerDemo = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth/1.84+StatusBarHeight))
        // 是否自动滚动
        self.bannerDemo.autoScroll = true
        
        // 是否无限循环，此属性修改了就不存在轮播的意义了 😄
        self.bannerDemo.infiniteLoop = true
        
        // 滚动间隔时间(默认为2秒)
        self.bannerDemo.autoScrollTimeInterval = 3.0
        
        // 等待数据状态显示的占位图
        self.bannerDemo.placeHolderImage = UIImage(named: "thumbImage")
        
        // 如果没有数据的时候，使用的封面图
        self.bannerDemo.coverImage = UIImage(named: "thumbImage")
        
        // 设置图片显示方式=UIImageView的ContentMode
        self.bannerDemo.imageViewContentMode = .scaleToFill
        
        // 设置滚动方向（ vertical || horizontal ）
        self.bannerDemo.scrollDirection = .horizontal
        
        // 设置当前PageControl的样式 (.none, .system, .fill, .pill, .snake)
        self.bannerDemo.customPageControlStyle = .snake
        
        // 非.system的状态下，设置PageControl的tintColor
//        self.bannerDemo.customPageControlInActiveTintColor = UIColor.red
        
        // 设置.system系统的UIPageControl当前显示的颜色
//        self.bannerDemo.pageControlCurrentPageColor = UIColor.white
        
        self.bannerDemo.pageControlActiveImage = UIImage(named: "home_AD")
        self.bannerDemo.pageControlInActiveImage = UIImage(named: "home_AD_act")
        
        // 非.system的状态下，设置PageControl的间距(默认为8.0)
        self.bannerDemo.customPageControlIndicatorPadding = 8.0
        
        // 设置PageControl的位置 (.left, .right 默认为.center)
        self.bannerDemo.pageControlPosition = .right
        //
        self.bannerDemo.pageControlBottom = 40
        // 添加到view
        self.addSubview(self.bannerDemo)
    }
    
}
