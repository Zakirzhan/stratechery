//
//  SettingsViewController.swift
//  stratechery
//
//  Created by macbook on 28.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//

import UIKit
import Cartography

import Cache


class SettingsViewController: UIViewController {
    
 
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "settingsCell")
        tableView.backgroundColor = UIColor(red:0.94, green:0.32, blue:0.24, alpha:1.0)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title =  "Settings"
        let save = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveSettings))
        self.navigationItem.rightBarButtonItem  = save
        view.addSubview(tableView)
        tableView.rowHeight = 50
         configureConstrains()
        let cache = HybridCache(name: "Mix")
        // Add object to cache
        do {
            try cache.addObject("This is a string", forKey: "string", expiry: .never)
        } catch {
            print("error")
        }
        
        // Get object from cache
        let string: String? = cache.object(forKey: "string") // "This is a string"
        print(string)
    }
    func saveSettings(){
        print("saved")
    }
    func configureConstrains(){
        constrain(tableView, view) { t, v in
            t.top == v.top
            t.left == v.left
            t.right == v.right
            t.bottom == v.bottom
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsTableViewCell
        cell.titleLabel.text = "Enable"
        cell.descriptionLabel.text = "Enable/Disable IQ/KeyboardManager"
        return cell
    }
}
