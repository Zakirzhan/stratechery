
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
import SDWebImage

class ViewController: UIViewController {
    var refreshControl:UIRefreshControl!
    var loadMoreStatus = false
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "singlePost")
        tableView.register(WithoutImgPostTableViewCell.self, forCellReuseIdentifier: "withoutImg")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = self.view.frame.height/5
        return tableView
    }()
    var posts = [Feed]()
    var countRow = 6
    var page:Int = 1  //First page is 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshCont()
        configureViews()
        configureConstraints()
        self.title = "Feeds"
        loadData(page: page)
        self.tableView.tableFooterView?.isHidden = true
        
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
    
    func configureViews() {
        tableView.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    func configureConstraints() {
        constrain(tableView, view) { tv, v  in
            tv.edges == v.edges
        }
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let imgLink = posts[indexPath.row].imageLink {
            let cell = tableView.dequeueReusableCell(withIdentifier: "singlePost", for: indexPath) as! PostTableViewCell
            cell.imgView.sd_setImage(with: URL(string: imgLink), placeholderImage: UIImage(named: "no-image"))
            cell.label.text = posts[indexPath.row].title
            if let postDate = posts[indexPath.row].date {
                let dateString = String(postDate.characters.dropLast(15))
                print(dateString)
                let dateFormatter = DateFormatter()
                if let dateParsed = dateFormatter.date(fromNASAString: dateString) {
                    let stringDate = dateFormatter.weekDays(from: dateParsed)
                    cell.dateLabel.text = stringDate
                }
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "withoutImg", for: indexPath) as! WithoutImgPostTableViewCell
            cell.descriptionLabel.text = posts[indexPath.row].description
            cell.label.text = posts[indexPath.row].title
            return cell
        }
        
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
}
extension DateFormatter {
    func date(fromNASAString dateString: String) -> Date? {
        self.dateFormat = "yyyy-MM-dd"
        self.timeZone = TimeZone(abbreviation: "UTC")
        self.locale = Locale(identifier: "en_US_POSIX")
        return self.date(from: dateString)
    }
    
    func weekDays(from mydate:Date) -> String? {
        self.dateFormat = "EEEE, MMM d, yyyy"
        self.timeZone = TimeZone(abbreviation: "UTC")
        self.locale = Locale(identifier: "en_US_POSIX")
        return self.string(from: mydate)
    }
}


