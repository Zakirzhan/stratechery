
//
//  ViewController.swift
//  stratechery
//
//  Created by macbook on 13.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//
import UIKit
import Cartography
import Alamofire
import ObjectMapper 
class ViewController: UIViewController {
   
    var openedMenu = false
    
    let headMenu = HeadMenuView(frame: CGRect.zero)

    var refreshControl:UIRefreshControl!
    var loadMoreStatus = false
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "singlePost") 
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = self.view.frame.height/2
//        let gradient = CAGradientLayer()
//        
//        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
//        gradient.colors = [UIColor(red:1.00, green:0.98, blue:0.94, alpha:1.0).cgColor, UIColor.white.cgColor]
//        
//        tableView.layer.insertSublayer(gradient, at: 0)
        return tableView
    }()
    var posts = [Feed]()
    var countRow = 6
    var page:Int = 1  //First page is 1
    
    var headMenuConstraintGroup: ConstraintGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var hamButton = UIImage(named: "hamburger")
        let hamburger = UIBarButtonItem(image: hamButton, style: .plain, target: self, action: #selector(openMenu(_:)))
        self.navigationItem.leftBarButtonItem  = hamburger

        refreshCont()
        configureViews()
        configureConstraints()
        configureHeadMenuConstraints()
        self.title = "Feeds"

        loadData(page: page)
        self.tableView.tableFooterView?.isHidden = true
        
    }
    
    
    func configureViews() {
        tableView.backgroundColor = .white
        headMenu.parentVC = self
        view.addSubview(headMenu)
        view.addSubview(tableView)
    }
    
    func configureConstraints() {
        constrain(headMenu,tableView, view) { hm, tv, v in
            tv.top == hm.bottom
            tv.left == v.left
            tv.right == v.right
            tv.width == v.width
            tv.height == v.height
        }
    }
    
    func configureHeadMenuConstraints() {
        headMenuConstraintGroup = constrain(headMenu, view, replace: headMenuConstraintGroup) { hm, v in
            hm.bottom == v.top
            hm.centerX == v.centerX
            hm.height == v.height/3
            hm.width == v.width
        }
    }
    
    func updateConstraints(){
        headMenuConstraintGroup = constrain(view, headMenu, replace: headMenuConstraintGroup) { v, hm in
            hm.top == v.top
            hm.centerX == v.centerX
            hm.height == v.height/3
            hm.width == v.width
        }
    }
    func openMenu(_ : UIButton){
        view.setNeedsUpdateConstraints()
        if !openedMenu {
            UIView.animate(withDuration: 0.7, animations: {
                self.updateConstraints()
                self.view.layoutIfNeeded()
                
            })
        }
        else {
            UIView.animate(withDuration: 0.7, animations: {
                self.configureHeadMenuConstraints()
                self.view.layoutIfNeeded()
            })
            

        }
        openedMenu = !openedMenu
//        print(openedMenu)
    }

    
    func loadData(page: Int) {
        Feed.fetchFeed(page: page) { [unowned self] (feeds, error) in
            guard let feedList = feeds else { return }
            if page != 1 {
                Feed.fetchFeed(page: page) { [unowned self] (feeds, error) in
                    guard let feedList = feeds else { return }
                    for arr in feedList {
                        self.posts.append(arr)
                    }
                }
            }
            else {
                self.posts = feedList
            }
            self.tableView.reloadData()
        }
    }
    func refreshCont() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Идет обновление...")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject) {
        refreshBegin(newtext: "Refresh",
                     refreshEnd: {(x:Int) -> () in
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
        })
    }
    
    func refreshBegin(newtext:String, refreshEnd:@escaping (Int) -> ()) {
        DispatchQueue.global().async {
            print("refreshing")
            Feed.fetchFeed(page: 1) { [unowned self] (feeds, error) in
                guard let feedList = feeds else { return }
                var i: Int = 0
                for arr in feedList {
                    self.posts[i].title = arr.title
                    self.posts[i].description = arr.description
                    self.posts[i].imageLink = arr.imageLink
                    self.posts[i].date = arr.date
                    self.posts[i].link = arr.link
                i += 1
                }
                self.tableView.reloadData()
            }
            sleep(2)
            
            DispatchQueue.main.async() {
                refreshEnd(0)
            }
        }
    }
    
    func loadMore() {
        if ( !loadMoreStatus ) {
            self.loadMoreStatus = true
            self.tableView.tableFooterView?.isHidden = false
            loadMoreBegin(newtext: "ZHANym", loadMoreEnd: {(x:Int) -> () in
                            self.page += 1
                            self.loadData(page: self.page)
                            self.tableView.reloadData()
                            self.loadMoreStatus = false
                            self.tableView.tableFooterView?.isHidden = false
            })
        }
    }
    
    func loadMoreBegin(newtext:String, loadMoreEnd:@escaping (Int) -> ()) {
        DispatchQueue.global().async {
            sleep(2)
            
            DispatchQueue.main.async() {
                loadMoreEnd(0)
            }
        }
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "singlePost", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(with: post)
        return cell        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // print("this is the last cell")
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToPostVC(posts[indexPath.row])
    }
    
    func goToPostVC(_ post: Feed) {
        let vc = PostViewController()
        vc.myPost = post
        navigationController?.pushViewController(vc, animated: true)
    }
}

