//
//  DiscountViewController.swift
//  swift_Community
//
//  Created by MM on 2018/10/24.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import HandyJSON

class DiscountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    private var datas:NSMutableArray = {() -> NSMutableArray in
        let arr = NSMutableArray.init()
        return arr;
    }()
    private var categorys:NSMutableArray = {() -> NSMutableArray in
        let arr = NSMutableArray.init()
        return arr;
    }()
    private var selectedIndex = 0
    private var currentPage:Int = 0
    private var disType:Int = 0
    private lazy var headerView:DiscountHeaderView = {() -> DiscountHeaderView in
        let header = DiscountHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 60))
        header.delegate = (self as DiscountHeaderViewProtocol)
        return header
    }()
    private lazy var categoryTableView:DiscountCategory = {() -> DiscountCategory in
        var height:CGFloat = CGFloat(categorys.count * 50)
        if (self.categorys.count*50 > Int((ScreenHeight-TabBarHeight-60))){
            height = CGFloat(ScreenHeight-TabBarHeight-60)
        }
        let tv = DiscountCategory.init(frame: CGRect.init(x: 0, y: 60, width: ScreenWidth, height: height), style: .plain)
        tv.selectedDelegate = self as DiscountCategoryProtocol
        tv.isHidden = true
        return tv
    }()
    private lazy var tableView : UITableView = {() -> UITableView in
        let tv = UITableView(frame: CGRect(x: 0, y: 60, width: ScreenWidth, height: ScreenHeight-TabBarHeight-60), style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.register(UINib.init(nibName: String(describing: DiscountTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DiscountTableViewCell.self))
        //下拉刷新
        // Initialize tableView
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tv.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            // Do not forget to call dg_stopLoading() at the end
            self?.refreshFromOne()
        }, loadingView: loadingView)
        tv.dg_setPullToRefreshFillColor(UIColor.groupTableViewBackground)
        tv.dg_setPullToRefreshBackgroundColor(tv.backgroundColor!)
        return tv;
    }()
    deinit {
        self.tableView.dg_removePullToRefresh()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.tableView)
        self.requestCategorys()
        self.refreshFromOne()
    }
    private func refreshFromOne(){
        self.currentPage = 0
        self.datas.removeAllObjects()
        self.requestData()
    }
    private func requestData(){
        var cid = "0"
        if (self.selectedIndex != 0) {
            let model:CategorysModel = self.categorys[self.selectedIndex] as! CategorysModel
            cid = model.cid!
        }
        let params = [
            "requestCommand" : "getAllDiscounts",
            "uid" : "37",
            "lat" : "40",
            "longt" : "120",
            "pageNow" : (++self.currentPage),
            "pageCount" : "15",
            "disType" : self.disType,
            "cid" : cid == "0" ? nil:cid
            ] as [String : Any]
        NetworkTool.request(mHttpImage, params: params, cache: false, success: { (data, code, message) in
            if code == .NetworkRetcodeSuccess {
                print("成功");
                let shopsStr = data["shops"];
                let shops = [DiscountModel].deserialize(from: (shopsStr as! NSArray))
                self.datas.addObjects(from: shops! as [Any])
                self.tableView.reloadData()
            }else{
                print("失败");
            }
            self.tableView.dg_stopLoading()
        }) { (error) in
            self.tableView.dg_stopLoading()
        }
    }
    private func requestCategorys(){
        let params = [
            "requestCommand" : "getDiscountCategories",
            "uid" : "37"
            ] as [String : Any]
        NetworkTool.request(mHttpImage, params: params, cache: false, success: { (data, code, message) in
            if code == .NetworkRetcodeSuccess {
                print("成功");
                let categoryStr = data["categories"];
                self.categorys.removeAllObjects()
                self.categorys.addObjects(from: [CategorysModel].deserialize(from: (categoryStr as! NSArray))! as [Any])
                let first : CategorysModel = CategorysModel.init()
                first.cid = "0"
                first.cTitle = "All Category"
                self.categorys.insert(first, at: 0)
                self.view.addSubview(self.categoryTableView)
                self.categoryTableView.datas = self.categorys as! [CategorysModel]
                self.categoryTableView.reloadData()
            }else{
                print("失败");
            }
            self.tableView.dg_stopLoading()
        }) { (error) in
            self.tableView.dg_stopLoading()
        }
    }
    //MARK: -- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DiscountTableViewCell.self), for: indexPath) as! DiscountTableViewCell
        cell.model = (self.datas[indexPath.row] as! DiscountModel);
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: UITableViewHeaderFooterView.self))
        return footer
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
}
//MARK: -- DiscountHeaderViewProtocol
extension DiscountViewController:DiscountHeaderViewProtocol{
    func clickCallBack(tag: Int) {
        self.disType = tag
        switch tag {
            case 0:
                do {
                        print("所有分类")
                        self.categoryTableView.isHidden = !self.categoryTableView.isHidden
                   }
            case 1:
                print("最近发布")
            case 2:
                print("距离最近")
            default:
                do{
                    print("12均未选中")
                    self.disType = 0
                    }
         }
        refreshFromOne()
    }
}
extension DiscountViewController:DiscountCategoryProtocol{
    func SelectedIndex(index: NSInteger) {
        let model:CategorysModel = self.categorys[index] as! CategorysModel
        self.headerView.categoryBtn?.setTitle(model.cTitle, for: .normal)
        self.categoryTableView.isHidden = true
        self.selectedIndex = index
        refreshFromOne()
    }
}
