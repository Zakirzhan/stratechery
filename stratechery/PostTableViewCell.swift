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
        label.font = UIFont(name: "Times New Roman", size: 24)
        // label.backgroundColor = .black
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "Wednesday"
        dateLabel.font = UIFont(name: "Times New Roman", size: 16)
        dateLabel.textColor = .gray
        // label.backgroundColor = .black
        return dateLabel
    }()
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        return imgView
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
        contentView.addSubview(imgView)
        contentView.addSubview(label)
        contentView.addSubview(dateLabel)
    }
    
    func configureConstraints() {
        label.frame = contentView.frame
        constrain(self, label, dateLabel, imgView) { s, l, d, i in
            i.left == s.left
            i.top == s.top
            d.right == s.right
            d.top == s.top
            l.top == s.top
            l.left == i.right + 10
            
        }
    }
    
    
}
