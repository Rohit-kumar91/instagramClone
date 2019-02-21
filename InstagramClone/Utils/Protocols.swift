//
//  Protocols.swift
//  InstagramClone
//
//  Created by Rohit Prajapati on 12/02/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//


protocol UserProfileHeaderDelegate {
    func handleEditFollowTapped(for header: UserProfileHeader)
    func setUserStats(for header: UserProfileHeader)
//    func handleFollowersTapped(for header: UserProfileHeader)
//    func handleFollowingTapped(for header: UserProfileHeader)
}
