//
//  PostTableViewCell.swift
//  stratechery
//
//  Created by macbook on 13.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//

import UIKit
import Cartography


class PostTableViewCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "ZAKA"
        label.textColor = .green
       // label.backgroundColor = .black
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        contentView.addSubview(label)
    }
    
    func configureConstraints() {
        label.frame = contentView.frame
        constrain(self, label) { s, l in
            l.center == s.center
        }
    }
    

}
