//
//  CategoryViewController.swift
//  stratechery
//
//  Created by macbook on 26.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//


import UIKit
import  Cartography

class ReviewsVC: UIViewController {
    var page: MyPage?
    var post: Page?
    lazy var webView: UIWebView = {
        let web = UIWebView()
        return web
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Page.parsePage(year: (page?.year)!) { [unowned self] (feeds, error) in
            if let feedList = feeds {
                self.post = feedList
                if let tempPost = self.post {
                    //            navigationItem.title = tempPost.title!
                                self.webView.loadHTMLString(tempPost.html!, baseURL: nil)
                    
                    //            urlPage = tempPost.link!
                    //            loadData(url: urlPage)
                }

            }
                else {
            print(error)
            }
         }
        configureViews()
        constrains()
    }
    
    func configureViews() {
        view.addSubview(webView)
        
    }
    
    
    func constrains(){
        constrain(webView, view){  w, v  in
            w.top == v.top
            w.width == v.width - 20
            w.centerX == v.centerX
            
            w.height == v.height
            
            //            bb.center == v.center
            //            bb.width == v.width/4
            //            bb.height == v.height/10
        }
    }
}
