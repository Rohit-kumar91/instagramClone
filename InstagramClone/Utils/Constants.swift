//
//  Constants.swift
//  InstagramClone
//
//  Created by Rohit Prajapati on 07/02/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import Firebase


// MARK: - Root References

let DB_REF = Database.database().reference()
let STORAGE_REF = Storage.storage().reference()

// MARK: - Database References

let USER_REF = DB_REF.child("users")
let USER_FOLLOWER_REF = DB_REF.child("user-followers")
let USER_FOLLOWING_REF = DB_REF.child("user-following")
