//
//  MainTabController.swift
//  InstagramClone
//
//  Created by Rohit Prajapati on 03/02/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure view controller
        confirgureViewController()
        
        //user validation
        chechIfUserIsLogin()
    }
    
    // function create the view controller that exist in the tab bar.
    func confirgureViewController() {
        
        //home feed controller
        let feedVC = constructNavController(selectedImage: #imageLiteral(resourceName: "home_selected"), unSelectedImage: #imageLiteral(resourceName: "home_unselected"), rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //search feed controller
        let searchVC = constructNavController(selectedImage: #imageLiteral(resourceName: "search_selected"), unSelectedImage:#imageLiteral(resourceName: "search_unselected"), rootViewController: SearchVC())
        
        //post controller
        let uploadPostVC = constructNavController(selectedImage: #imageLiteral(resourceName: "plus_unselected"), unSelectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: UploadVCViewController())
        
        //notification controller
        let notificationVC = constructNavController(selectedImage: #imageLiteral(resourceName: "like_selected"), unSelectedImage: #imageLiteral(resourceName: "like_unselected"), rootViewController: NotificationVCTableViewController())
        
        //profile controller
        let profileVC = constructNavController(selectedImage: #imageLiteral(resourceName: "profile_selected"), unSelectedImage: #imageLiteral(resourceName: "profile_unselected"), rootViewController: UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        
        //View controller to added to tab bar
        viewControllers = [feedVC, searchVC, uploadPostVC, notificationVC, profileVC]
        
        //tabbar tint color black
        tabBar.tintColor = .black
        
        
    }
    
    
    //construct Nav controller
    func constructNavController(selectedImage: UIImage, unSelectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        //Construct nav bar.
        let navController  = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unSelectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        
        //return nav controller.
        return navController
        
    }
    
    func chechIfUserIsLogin() {
        if Auth.auth().currentUser == nil {
            print("There is no current user here...")
            
            DispatchQueue.main.async {
                let loginVC = LoginViewController()
                let navigationController = UINavigationController(rootViewController: loginVC)
                self.present(navigationController, animated: true, completion: nil)
            }
            
        }
        
        return
    }
    
    

}
