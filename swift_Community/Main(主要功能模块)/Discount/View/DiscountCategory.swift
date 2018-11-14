//
//  DiscountCategory.swift
//  swift_Community
//
//  Created by MM on 2018/11/13.
//  Copyright © 2018年 MM. All rights reserved.
//

import UIKit

protocol DiscountCategoryProtocol:NSObjectProtocol {
    func SelectedIndex(index:NSInteger)
}
class DiscountCategory: UITableView,UITableViewDelegate,UITableViewDataSource  {
    var datas:[CategorysModel] = []
    var selectedIndex = 0
    weak var selectedDelegate:DiscountCategoryProtocol?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
    
    //MARK: -- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        let model = self.datas[indexPath.row]
        cell.textLabel?.text = model.cTitle
        if (selectedIndex == indexPath.row) {
            cell.textLabel?.textColor = ThemeColor
        }else{
            cell.textLabel?.textColor = UIColor.black
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.reloadData()
        selectedDelegate?.SelectedIndex(index: indexPath.row)
    }
    
}
