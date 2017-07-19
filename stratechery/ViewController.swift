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
import AlamofireObjectMapper
//import AlamofireObjectMapper


class ViewController: UIViewController {
    var projects:[Project] = []

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "stratecheryPost")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
         configureViews()
        configureConstraints()
        self.title = "SEX"
        fetchData()
        
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
    
    
    func fetchData(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let apiUrl = "http://uka.kz/?type=feed&page=1"
        Alamofire.request(apiUrl).responseJSON(completionHandler: { (DataResponse<[Project]>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result {
            case .success:
                self.projects = response.result.value ?? []
                for project in self.projects {
                    print(project.title ?? "")
                }
            case .failure(let error):
                print(error)
            }
        }
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stratecheryPost", for: indexPath) as! PostTableViewCell
        cell.label.text = "MAKA"
        return cell
    }
    
    
}
