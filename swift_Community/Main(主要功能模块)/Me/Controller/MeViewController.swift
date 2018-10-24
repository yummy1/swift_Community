//
//  MeViewController.swift
//  swift_Community
//
//  Created by MM on 2018/9/18.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit
import HandyJSON


class MeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    private var model: MeModel? = nil
    private lazy var datas = { () -> [[[String:String]]] in
        let arr = [[["icon":"me-Profile","title":"Profile"],["icon":"me-Home-Management","title":"HomeManagement"],["icon":"me-Add-Visitor","title":"AddVisitor"]],[["icon":"me-Settings","title":"Settings"],["icon":"me-Feedback","title":"Feedback"],["icon":"me-About-us","title":"About us"]]]
        return arr
    }()
    private lazy var tableView:UITableView = {() -> UITableView in
        let tv = UITableView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorInset = UIEdgeInsets.zero
        tv.separatorColor = RGB(200, g: 200, b: 200)
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.tableFooterView = UIView.init()
        tv.register(MeHomeTableViewCell.self, forCellReuseIdentifier: String(describing: MeHomeTableViewCell.self))
        tv.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tv.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: String(describing: UITableViewHeaderFooterView.self))
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        requestData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    private func requestData(){
        let params = [
        "requestCommand" : "getUserProfile",
        "uid" : "37"
        ]
        NetworkTool.request(mHttpUser, params: params, cache: true, success: { (data, code, message) in
        if code == .NetworkRetcodeSuccess {
        print("成功");
        self.model = MeModel.deserialize(from: data)
        self.tableView.reloadData()
        }else{
        print("失败");
        }
        }) { (error) in
    
        }
    }
    //MARK: -- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }else{
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MeHomeTableViewCell.self), for: indexPath) as! MeHomeTableViewCell
            if (self.model != nil){
                cell.model = self.model!
            }
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            let dic = self.datas[indexPath.section-1][indexPath.row]
            let cellModel:SettingsModel = SettingsModel.deserialize(from: dic)!
            cell.imageView?.image = UIImage.init(named: cellModel.icon!)
            cell.textLabel?.text = cellModel.title
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 200 + NavgationBarHeight
        }else{
            return 60
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: UITableViewHeaderFooterView.self))
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 2) {
            return 5
        }else{
            return 0.001
        }
    }
}
