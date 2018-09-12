//
//  HomeViewController.swift
//  swift_Community
//
//  Created by MM on 2018/9/4.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import DaisyNet
import ObjectMapper
import HandyJSON

class HomeViewController: UIViewController {
    
    private var collectionView:UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestHomeData()
        
    }

    private func requestHomeData() {
        let params = [
            "requestCommand" : "homeDetails",
            "uid" : "37"
            ]
        NetworkTool.request(mHttpHome, params: params, cache: true, success: { (data, code, message) in
            if code == .NetworkRetcodeSuccess {
                print("成功");
                let model = HomeModel.deserialize(from: data)
                print(model?.cName)
                
            }else{
                print("失败");
            }
        }) { (error) in
            
        }
        
    }
    
}
