
//
//  MenuItemTableViewCell.swift
//  stratechery
//
//  Created by macbook on 26.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//

import UIKit
import Cartography

class SettingsTableViewCell: UITableViewCell {
    
    
    lazy var switchDemo:UISwitch = {
        let switchDemo = UISwitch()
        switchDemo.isOn = true
        switchDemo.setOn(true, animated: false)
        switchDemo.addTarget(self, action: #selector(enabled(_:)), for: .valueChanged)
        return switchDemo
    }()
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: 19.0)
        label.textColor = .black
        return label
    }()
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 13.0)
        label.textColor = .gray
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(switchDemo)

        configureViews()
        configureConstrains()

        self.backgroundColor = UIColor(red:1.00, green:0.82, blue:0.76, alpha:1.0)
        self.contentView.backgroundColor = UIColor(red:1.00, green:0.82, blue:0.76, alpha:1.0)
        
        
    }
    func enabled(_ sender:UISwitch){
        print(sender)
    }
    func configureViews() {
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
    }
    
    func configureConstrains(){
        constrain(self, titleLabel, descriptionLabel, switchDemo){s,title,description,sw in
            title.left == s.left + 16
            title.top == s.top + 5
            description.top == title.bottom + 5
            description.left ==  s.left + 16
            sw.right == s.right - 16
            sw.top == s.top 
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented coder")
    }
    
    
}
