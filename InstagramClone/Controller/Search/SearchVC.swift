//
//  SearchVC.swift
//  InstagramClone
//
//  Created by Rohit Prajapati on 03/02/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "SearchTableviewCell"

class SearchVC: UITableViewController {

    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register cell class.
        tableView.register(SearchTableviewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        //seperator insets
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)

        configureNavController()
        fetchUser()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchTableviewCell
        cell.user = users[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        //create instance of user profileVC
        let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        userProfileVC.userToLoadSearchVC = user
        self.navigationController?.pushViewController(userProfileVC, animated: true)
        
    }


    func configureNavController() {
        navigationItem.title = "Explore"
    }
    
    func fetchUser(){
        
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            print(snapshot)
            
            //uid
            let uid  = snapshot.key
            
            //snapshot value cast as a dictionary
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            
            //construct user
            let user = User(uid: uid, dictionary: dictionary)
            
            // append user to datasource.
            self.users.append(user)
            
            //reload tableview
            self.tableView.reloadData()
            
        }
        
    }
    

}
