//
//  PostTableViewCell.swift
//  stratechery
//
//  Created by macbook on 13.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//
import UIKit
import Cartography


class WithoutImgPostTableViewCell: UITableViewCell {
    
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
    
    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Wednesday"
        descriptionLabel.numberOfLines = 6
        descriptionLabel.font = UIFont(name: "Times New Roman", size: 18)
        descriptionLabel.textColor = .gray
        // label.backgroundColor = .black
        return descriptionLabel
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
//        print(dateLabel.text!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(label)
        contentView.addSubview(dateLabel)
    }
    
    func configureConstraints() {
        label.frame = contentView.frame
        constrain(self, label, dateLabel, descriptionLabel) { view, label, date, dL in
            label.top == view.top + 5
            label.left == view.left + 10
            dL.top == label.bottom
            dL.left == view.left + 10
            date.top == (view.top + 10)
            date.right == (view.right - 10)
            label.width == 2*view.width/3
            dL.width == view.width
            dL.height == view.height/2
        }
    }
    
    
}
