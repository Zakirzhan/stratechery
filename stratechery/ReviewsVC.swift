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
        web.delegate = self

        return web
    }()
    lazy var activityIndicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        //        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        return activityIndicator
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        view.backgroundColor = .white
        navigationItem.title = page?.title
        Page.parsePage(type: (page?.type)!, id: (page?.id)!) { [unowned self] (feeds, error) in
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
        view.addSubview(activityIndicator)
        
    }
    
    
    func constrains(){
        constrain(webView, activityIndicator, view){  w, ai, v  in
            w.top == v.top
            w.width == v.width - 20
            w.centerX == v.centerX
            
            w.height == v.height
            ai.center == v.center

            
            //            bb.center == v.center
            //            bb.width == v.width/4
            //            bb.height == v.height/10
        }
    }
}

extension ReviewsVC: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
        
    }
}
