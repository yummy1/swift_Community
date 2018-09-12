//
//  MMGlobalMethod.swift
//  swift_Community
//
//  Created by MM on 2018/9/4.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit

// MARK: -- 颜色
/// RGB
func RGB(_ r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
    return RGBA(r, g: g, b: b, a: 1.0)
}

/// RGBA
func RGBA(_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}


// MARK: -- 尺寸计算 以iPhone6为比例
func MMSizeW(_ size:CGFloat) ->CGFloat {
    return size * (ScreenWidth / 375)
}

func MMSizeH(_ size:CGFloat) ->CGFloat{
    return size * (ScreenHeight / 667)
}
