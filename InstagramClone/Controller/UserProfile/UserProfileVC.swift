//
//  UserProfileVC.swift
//  InstagramClone
//
//  Created by Rohit Prajapati on 03/02/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let headerIdentifier = "userProfileHeader"

class UserProfileVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserProfileHeaderDelegate{
    
    
    
    // Mark: Properties
    var currentUser: User?
    var userToLoadSearchVC: User?
    

    override func viewDidLoad() {
        super.viewDidLoad()


        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        //background Color of collectionview
        self.collectionView.backgroundColor = .white
        
        
        if userToLoadSearchVC == nil {
            fetchCurrentUserData()
        }
        
        

    }

   
    // MARK: UICollectionView

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //declare header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
        
        // set delegate
        header.delegate = self
        
        //set the user in header..
        if let user = self.currentUser {
            header.user = user
        } else {
            if let userToLoadSearchVC = userToLoadSearchVC {
                header.user = userToLoadSearchVC
                navigationItem.title = userToLoadSearchVC.username
            }
        }
        
        
        return header
        
    }

    
    
    
    // MARKS: - API
    func fetchCurrentUserData() {
        
        print("In Fetch date.")
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(currentUid).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot)
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            let user = User(uid: snapshot.key, dictionary: dictionary)
            self.navigationItem.title = user.username
            self.currentUser = user
            self.collectionView.reloadData()

        }
    }
    
    
    
    //MARK : UserProfileHeader Protocol
    func handleEditFollowTapped(for header: UserProfileHeader) {
        
        guard let user = header.user else { return }
        
        if header.editProfileFollowButton.titleLabel?.text == "Edit Profile" {
            
            
        } else {
            
            if header.editProfileFollowButton.titleLabel?.text == "Follow" {
                header.editProfileFollowButton.setTitle("Following", for: .normal)
                user.follow()
            } else {
                header.editProfileFollowButton.setTitle("Follow", for: .normal)
                user.unfollow()
            }
        }
    }
    
    func setUserStats(for header: UserProfileHeader) {
        
        guard let user = header.user else { return }
        var numberOfFollower: Int!
        var numberOfFollowing: Int!
        
        USER_FOLLOWER_REF.child(user.uid).observe(.value) { (snapshot) in
            if let snapshot = snapshot.value as? Dictionary<String, AnyObject> {
                numberOfFollower = snapshot.count
            } else {
                numberOfFollower = 0
            }
            
            let attributedText = NSMutableAttributedString(string: "\(numberOfFollower!)\n", attributes: [NSMutableAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: "followers", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            header.followersLabel.attributedText = attributedText
            
            
        }
        
        
        USER_FOLLOWING_REF.child(user.uid).observe(.value) { (snapshot) in
            if let snapshot = snapshot.value as? Dictionary<String, AnyObject> {
                numberOfFollowing = snapshot.count
            } else {
                numberOfFollowing = 0
            }
            
            let attributedText = NSMutableAttributedString(string: "\(numberOfFollowing!)\n", attributes: [NSMutableAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: "following", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            header.followingLabel.attributedText = attributedText
        }
    }
    
    
}
