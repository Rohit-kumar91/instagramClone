//
//  SearchTableviewCell.swift
//  InstagramClone
//
//  Created by Rohit Prajapati on 05/02/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit

class SearchTableviewCell: UITableViewCell {

    //MARK: Properties.
    
    var user: User? {
        didSet {
            
            guard let profileImageUrl = user?.profileImageUrl else { return }
            guard let username = user?.username else { return }
            guard let fullname = user?.name else { return }
            
            profileImageView.loadImage(with: profileImageUrl)
            self.textLabel?.text = username
            self.detailTextLabel?.text = fullname
            
            
        }
    }
    
    
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        //add profile Image view
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 48, height: 48)
        
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.layer.cornerRadius = 48/2
        profileImageView.clipsToBounds = true
        
        
        self.textLabel?.text = "Username"
        self.detailTextLabel?.text = "Fullname "
        
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 68, y: (textLabel?.frame.origin.y)! - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        detailTextLabel?.frame = CGRect(x: 68, y: (detailTextLabel?.frame.origin.y)! - 2, width: self.frame.width - 108, height: (detailTextLabel?.frame.height)!)
        detailTextLabel?.textColor  = .lightGray
        detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}