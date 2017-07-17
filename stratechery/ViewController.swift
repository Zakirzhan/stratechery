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
//import AlamofireObjectMapper


class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "stratecheryPost")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var posts = [Feed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         configureViews()
        configureConstraints()
        self.title = "SEX"
        
        Feed.fetchFeed() { [unowned self] (feeds, error) in
            guard let feedList = feeds else { return }
            self.posts = feedList
            self.tableView.reloadData()
//            self.feedList = feedList
//            print(feedList)
//            self.tableView.reloadData()
        }

        
        
        
    }
    func configureViews() {
        tableView.backgroundColor = .red
        view.addSubview(tableView)
    }

    func configureConstraints() {
         constrain(tableView, view) { tv, v  in
            tv.edges == v.edges
        }
    }
    
//    }
//    // With Alamofire
//    func getFetch() {
//        Alamofire.request("http://uka.kz/?type=feed&page=1").responseObject({ (response: Mapper<Post>) -> Void in
//            if response.result.isSuccess {
//                print(response.result.value!)
//            }
//        })
//    }
    
}
//struct Post: Mappable {
//    var title = ""
//    var url = ""
//    var imgUrl = ""
//    var date  = ""
//    
//    init?(map: Map) {}
//    mutating func mapping(map: Map) {
//        title <- map["title"]
//        url <- map["url"]
//        imgUrl <- map["image"]
//        date <- map["date"]
//    }
//}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stratecheryPost", for: indexPath) as! PostTableViewCell
        cell.label.text = posts[indexPath.row].title
        return cell
    }
    
    
}
