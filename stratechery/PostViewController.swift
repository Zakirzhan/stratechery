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
        return web
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "Wednesday"
        dateLabel.font = UIFont(name: "Times New Roman", size: 18)
        dateLabel.textColor = .gray
        return dateLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViews()
        constrains()
        if let tempPost = myPost { 
//            navigationItem.title = tempPost.title!
            webView.loadHTMLString(tempPost.html!, baseURL: nil)
            
//            urlPage = tempPost.link!
//            loadData(url: urlPage)
        }
        }
    
    func configureViews() { 
        view.addSubview(webView)
        
    }
    
    
    func constrains(){
        constrain(webView, view){  w, v  in
            w.top == v.top + 5
            w.width == v.width - 20
            w.centerX == v.centerX
            
            w.height == v.height
            
//            bb.center == v.center
//            bb.width == v.width/4
//            bb.height == v.height/10
        }
    }
}

