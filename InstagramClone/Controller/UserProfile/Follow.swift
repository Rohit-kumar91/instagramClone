//
//  Follow.swift
//  InstagramClone
//
//  Created by Rohit Prajapati on 23/02/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class FollowVC: UITableViewController {
    
    
    //MARK: Properties
    var viewFollowers = false
    var viewFollowing = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register tableview cell.
        tableView.register(FollowCellTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        //configure Nav Controller
        if viewFollowers {
             navigationItem.title = "Followers"
        } else {
             navigationItem.title = "Followings"
        }
        
       
        
    }
    
    //MARK: UITableview DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FollowCellTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}



