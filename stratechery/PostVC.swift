//
//  PostViewController.swift
//  stratechery
//
//  Created by macbook on 20.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//

import UIKit
import  Cartography

class PostViewController: UIViewController {

    var myPost: Feed?
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
        view.backgroundColor = .white
        configureViews()
        constrains()
        self.activityIndicator.startAnimating()
        if let tempPost = myPost { 
//            navigationItem.title = tempPost.title!
            webView.loadHTMLString(tempPost.html!, baseURL: nil)

//            urlPage = tempPost.link!
//            loadData(url: urlPage)
        }
        }
    
    func configureViews() {
        view.addSubview(webView)
        view.addSubview(activityIndicator)
    }
    
    
    func constrains(){
        constrain(webView,activityIndicator, view){  w, ai, v  in
            w.top == v.top + 5
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
extension PostViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
        
    }
}

