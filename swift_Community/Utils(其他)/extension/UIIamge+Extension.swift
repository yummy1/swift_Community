//
//  UIIamge+Extension.swift
//  swift_Community
//
//  Created by MM on 2018/9/4.
//  Copyright © 2018年 MM. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    

    
    
}
