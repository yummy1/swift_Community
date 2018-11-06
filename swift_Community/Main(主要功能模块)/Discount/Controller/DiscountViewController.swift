//
//  DiscountViewController.swift
//  swift_Community
//
//  Created by MM on 2018/10/24.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit

class DiscountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    private var datas:NSMutableArray? = nil
    private lazy var tableView : UITableView = {() -> UITableView in
        let tv = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-TabBarHeight), style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.separatorStyle = .none
        tv.register(UINib.init(nibName: String(describing: DiscountTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DiscountTableViewCell.self))
        tv.register(DiscountCategoryTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: DiscountCategoryTableViewHeaderView.self))
        return tv;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
    }
    private func requestData(){
        let params = [
            "requestCommand" : "homeDetails",
            "uid" : "37"
        ]
        NetworkTool.request(mHttpUser, params: params, cache: false, success: { (data, code, message) in
            if code == .NetworkRetcodeSuccess {
                print("成功");
            }else{
                print("失败");
            }
        }) { (error) in
            
        }
    }
    //MARK: -- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DiscountTableViewCell.self), for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: DiscountCategoryTableViewHeaderView.self))
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    

    
}
