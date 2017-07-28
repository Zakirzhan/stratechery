//
//  headMenu.swift
//  stratechery
//
//  Created by macbook on 26.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//

import UIKit
import Cartography

class HeadMenuView: UIView {
    var menu: [MyPage] = []
    var parentVC: UIViewController?
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(MenuItemsTableViewCell.self, forCellReuseIdentifier: "headMenu")
        tableView.backgroundColor = UIColor(red:0.94, green:0.32, blue:0.24, alpha:1.0)
        return tableView
    }()
    
    func getMenu() {
        self.addSubview(tableView)
        tableView.reloadData()
    }
    
    func constrainMenu(){
        constrain(tableView, self) { tv, hm in
            tv.edges == hm.edges
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        menu.append(MyPage(year: 2016, title: "The best news of 2016"))
        menu.append(MyPage(year: 2015, title: "The best news of 2015"))
        menu.append(MyPage(year: 2014, title: "The best news of 2014"))
        menu.append(MyPage(year: 2013, title: "The best news of 2013"))
        getMenu()
        constrainMenu()
        self.tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) not implemented")
    }
    
    
}

extension HeadMenuView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headMenu", for: indexPath) as! MenuItemsTableViewCell
        cell.menuTitleLabel.text = String(menu[indexPath.row].year)
        cell.imageView?.image = UIImage(named: "back")
        cell.imageView?.tintColor = .white
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToPostVC(menu[indexPath.row])
    }
    
    func goToPostVC(_ post: MyPage) {
        let vc = ReviewsVC()
        vc.page = post
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }

}




