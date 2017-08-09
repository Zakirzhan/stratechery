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
     var openedView = false
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
        
        menu.append(MyPage(type:"self", id: "feed", title: "Home", icon: "home"))
//        menu.append(MyPage(type:"self", id: "archives", title: "Archives", icon: "calendar"))
        menu.append(MyPage(type: "page", id: "about", title: "About me", icon: "about"))
//        menu.append(MyPage(type:"self", id: "settings", title: "Settings", icon: "settings"))
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
        cell.menuTitleLabel.text = String(menu[indexPath.row].title)
        cell.imageView?.image = UIImage(named: menu[indexPath.row].icon)
        cell.imageView?.image = cell.imageView?.image!.withRenderingMode(.alwaysTemplate)
        cell.imageView?.tintColor = .white
       cell.selectionStyle = .none
        return cell
    }
//    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        if menu[indexPath.row].type == "self" {
            switch menu[indexPath.row].id {
            case "settings":
                let vc = SettingsViewController()
                parentVC?.navigationController?.pushViewController(vc, animated: true)
            case "home":
                let vc = ViewController()
                parentVC?.navigationController?.pushViewController(vc, animated: true)
            default:
                let vc = ViewController()

                parentVC?.navigationController?.pushViewController(vc, animated: true)

            }
        }
        else {
            goToPostVC(menu[indexPath.row])
        }
    }
    func goToPostVC(_ post: MyPage) {
        let vc = ReviewsVC()
        vc.page = post
            parentVC?.navigationController?.pushViewController(vc, animated: true)
    }

}




