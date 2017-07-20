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
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Times New Roman", size: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 3
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "Wednesday"
        dateLabel.font = UIFont(name: "Times New Roman", size: 18)
        dateLabel.textColor = .gray
        // label.backgroundColor = .black
        return dateLabel
    }()
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()  // set as you want
        

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
        constrain(self, label, dateLabel, imgView) { view, label, date, img in
            img.left == view.left
            img.top == view.top
            img.height == view.height
            img.width == (view.width/2.5)
            label.top == (view.top + 10)
            label.left == (img.right + 5)
            label.right == (view.right - 10)
            date.bottom == (view.bottom - 10)
            date.right == (view.right - 10)
        }
    }
    
    
}
