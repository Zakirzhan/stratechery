//
//  PostTableViewCell.swift
//  stratechery
//
//  Created by macbook on 13.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//
import UIKit
import Cartography
import SDWebImage


class PostImageTableViewCell: UITableViewCell {
    
   private var layoutConfigured = false
    
    
    
    private var group = ConstraintGroup()
    public lazy var postImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 3
        label.textColor = UIColor(red:0.94, green:0.32, blue:0.24, alpha:1.0)
        return label
    }()
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        configureViews()
        configureConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        self.addSubview(postImageView)
        self.addSubview(titleLabel)
        self.addSubview(dateLabel)
    
    }
    
    func configureConstraints() {
        
        constrain(self,postImageView,titleLabel,dateLabel){s,imageView,title,date in

            title.top == s.top + 10
            title.left == s.left + 16
            title.width == s.width - 32
            
            date.top == title.bottom + 8
            date.left == s.left + 16
            
            imageView.width == s.width - 32
            imageView.height == s.width / 1.5
            imageView.centerX == s.centerX
            imageView.top == date.bottom + 16
            imageView.bottom == s.bottom - 10
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func configure(with post: Feed) {
        if let imageLink = post.imageLink,
            let url = URL(string: imageLink){
            postImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "no-image"))
        }
        titleLabel.text = post.title
        
        guard let dateString = post.date else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = dateFormatter.date(from: dateString) else { return }
        
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: date)
    }
    
    
}
