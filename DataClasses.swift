////
////  DataClasses.swift
////  Gimme
////
////  Created by Hossein Shirinabadi on 4/25/20.
////  Copyright © 2020 Stephen Boyle. All rights reserved.
////
//
//import Foundation
//import UIKit
//import CoreData
//import Firebase
//
//class User {
//
//    var username: String
//    var name: String
//    var email: String
//    var profilePic: UIImage
//    var feedData: FeedData
//
//    var giveaways: [Giveaway]
//    var gimmes: [Giveaway]
//
//    var followingUsers: [User]
//    var followers: [User]
//
//
//    init(name: String, username: String, email: String) {
//        self.name = name
//        self.username = username
//        self.email = email
//        self.profilePic = UIImage()
//    }
//
//    func addGiveAway(giveaway: Giveaway)  {
//        giveaways.append(giveaway)
//    }
//
//
//}
//
//class Giveaway {
//    var user: User
//    var postedTime: Date
//    var expiredTime: Date
//    var expired: Bool
//    var caption: Stirng
//    var maxNumWinners: Int
//    var donationUnit: Float
//    var joinedUsers: [User]
//    var likedUsers: [User]
//    var comments: [Comment]
//    var winners: [User]
//
//    init (user: user, postedTime: Date, expiredTime: Date, caption: String, donationAmount: Float) {
//        self.user = user
//        self.postedTime = postedTime
//        self.expiredTime = expiredTime
//        self.caption = caption
//        self.donationAmount = donationAmount
//        joinedUsers = []
//        likedUsers = []
//        comments = []
//    }
//
//    func addJoinedUser(user: User) {
//        joinedUsers.append(user)
//    }
//
//    func addLikedUser(user: User) {
//        likedUsers.append(user)
//    }
//
//    func addComment(comment: Comment) {
//        comments.append(comment)
//    }
//
//    func isExpired () -> Bool {
//        //how to check expiration
//        return true
//    }
//
//    func pickWinner () {
//        //randomly select winners
//    }
//
//}
//
//struct Comment {
//    var username: user
//    var commentText: String
//    var commentDate: Date
//    var numberOfLikes: Int
//}
//
//class FeedData {
//    var user: User
//    var giveaways: [Giveaway]
//
//
//    init() {
//        giveaways = []
//        updateFeed()
//
//    }
//
//    func updateFeed() {
//        for user in user.followingUsers {
//            for giveaway in user.giveaways {
//                if !giveaway.isExpired() {
//                    giveaways.append(giveaway)
//                }
//            }
//        }
//        sortGiveaways()
//    }
//
//    func sortGiveaways () {
//        giveaways.sorted(by: { $0.postedTime > $1.postedTime})
//    }
//}


