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

class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    private var model: HomeModel? = nil
    private let flowLayout : UICollectionViewFlowLayout = {() -> UICollectionViewFlowLayout in
        let flt = UICollectionViewFlowLayout.init()
        flt.minimumLineSpacing = 0
        flt.minimumInteritemSpacing = 0
        flt.scrollDirection = UICollectionViewScrollDirection.vertical
        flt.itemSize = CGSize(width: ScreenWidth, height: 100)
        return flt;
    }()
    private lazy var collectionView : UICollectionView = {() -> UICollectionView in
        let cView = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-TabBarHeight), collectionViewLayout: flowLayout)
        cView.dataSource = self
        cView.delegate = self
        cView.showsVerticalScrollIndicator = false
        cView.showsHorizontalScrollIndicator = false
        cView.backgroundColor = UIColor.groupTableViewBackground
        cView.register(HomeAdCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HomeAdCollectionViewCell.self))
        cView.register(UINib.init(nibName: String(describing: HomeModuleCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: HomeModuleCollectionViewCell.self))
        cView.register(UINib.init(nibName: String(describing: NewsListCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: NewsListCollectionViewCell.self))
        cView.register(UINib.init(nibName: String(describing: NewsListCollectionReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: NewsListCollectionReusableView.self))
        cView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        return cView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.addSubview(self.collectionView)
        requestHomeData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func requestHomeData() {
        let params = [
            "requestCommand" : "homeDetails",
            "uid" : "37"
            ]
        NetworkTool.request(mHttpHome, params: params, cache: true, success: { (data, code, message) in
            if code == .NetworkRetcodeSuccess {
                print("成功");
                self.model = HomeModel.deserialize(from: data)
                self.collectionView.reloadData()
            }else{
                print("失败");
            }
        }) { (error) in
            
        }
    }
    //MARK: -- UICollectionDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 2){
            if (self.model != nil){
                return (self.model?.news?.count)!
            }else{
                return 0
            }
        }else{
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeAdCollectionViewCell.self), for: indexPath) as! HomeAdCollectionViewCell
            if (self.model != nil) {
                cell.ads = self.model?.adImages
            }
            return cell
        }else if(indexPath.section == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeModuleCollectionViewCell.self), for: indexPath) as! HomeModuleCollectionViewCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NewsListCollectionViewCell.self), for: indexPath) as! NewsListCollectionViewCell
            if (self.model != nil) {
                cell.model = (self.model?.news![indexPath.item])!
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if (section == 1) {
            return UIEdgeInsetsMake(-25, 15, 15, 15);
        }else{
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.section == 0) {
            return CGSize(width: ScreenWidth, height: ScreenWidth/1.84+StatusBarHeight)
        }else  if (indexPath.section == 1) {
            return CGSize(width: (ScreenWidth-30), height: (ScreenWidth-30)*0.44/3+70)
        }else{
            return CGSize(width: ScreenWidth, height: 106)
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        if (indexPath.section == 2){
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: NewsListCollectionReusableView.self), for: indexPath)
            return header
        }else{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
            return header
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        if section == 2 {
            return CGSize(width: ScreenWidth, height: 50)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
