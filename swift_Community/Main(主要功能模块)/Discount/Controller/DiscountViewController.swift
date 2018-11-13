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
    private var currentPage:Int = 0
    private lazy var headerView:DiscountHeaderView = {() -> DiscountHeaderView in
        let header = DiscountHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 60))
        return header
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
        self .refreshFromOne();
    }
    private func refreshFromOne(){
        self.currentPage = 0
        self.datas.removeAllObjects()
        self.requestData()
    }
    private func requestData(){
        let params = [
            "requestCommand" : "getAllDiscounts",
            "uid" : "37",
            "lat" : "40",
            "longt" : "120",
            "pageNow" : (++self.currentPage),
            "pageCount" : "15",
            "disType" : "0"
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
    //MARK: -- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DiscountTableViewCell.self), for: indexPath) as! DiscountTableViewCell
        cell.model = (self.datas[indexPath.row] as! DiscountModel);
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    

    
}
