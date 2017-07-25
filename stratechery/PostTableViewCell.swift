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


class PostTableViewCell: UITableViewCell {
    
   private var layoutConfigured = false
    
    
    
    private var group = ConstraintGroup()
    public lazy var postImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Times New Roman", size: 24)
        label.numberOfLines = 2
        label.textColor = .blue
        return label
    }()
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Times New Roman", size: 16)
        label.textColor = .green
        return label
    }()
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
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
        self.addSubview(descriptionLabel)
    
    }
    
    func configureConstraints() {
        
        constrain(self,postImageView,titleLabel,dateLabel,descriptionLabel){s,imageView,title,date,description in

            title.top == s.top + 10
            title.left == s.left + 16
            
            date.top == title.bottom + 8
            date.left == s.left + 16
            
            imageView.width == s.width - 32
            imageView.height == s.width / 1.5
            imageView.centerX == s.centerX
            imageView.top == date.bottom + 16
            

            
            
        
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
        else {
            postImageView.isHidden = true
            descriptionLabel.text = post.description
            constrain(self,titleLabel,dateLabel,descriptionLabel){s,title,date,description in
                title.top == s.top + 8
                title.left == s.left + 16
                title.width == s.width - 32
                
                date.top == title.bottom + 8
                date.left == s.left + 16
                
                description.top == date.bottom + 8
                description.left == s.left + 16
                description.width == s.width - 32
            }
        
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
