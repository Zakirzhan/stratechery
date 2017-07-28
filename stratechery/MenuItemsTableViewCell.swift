
//
//  MenuItemTableViewCell.swift
//  stratechery
//
//  Created by macbook on 26.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//

import UIKit
import Cartography

class MenuItemsTableViewCell: UITableViewCell {
    
    
    public lazy var menuTitleLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 19.0)
        label.textColor = .white
        return label
    }()

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstrains()
        
    self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        

    }
        func configureViews() {
        self.addSubview(menuTitleLabel)
    }
    
    func configureConstrains(){
        constrain(self, menuTitleLabel, imageView!){s,t,i in
            i.left == s.left + 10
            i.centerY == s.centerY
            t.left == i.right + 5
            t.centerY == s.centerY
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
