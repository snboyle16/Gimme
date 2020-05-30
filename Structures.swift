//
//  Structures.swift
//  Gimme
//
//  Created by Hossein Shirinabadi on 4/25/20.
//  Copyright © 2020 Stephen Boyle. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase

struct Comment {
    var userID: String
    var username: String
    var commentText: String
    var commentDate: Date
    var numberOfLikes: Int
}

struct UserData {
    var username: String
    var email: String
    var paypal: String
    var giveaways: [String]
    var gimmes: [String]
    var joinedGimmes: [String]
    var followers: [String]
    var following: [String]
    var money: Float
    
    init(username: String? = nil, email: String? = nil, paypal: String? = nil,
         giveaways: [String]? = nil, gimmes: [String]? = nil, joinedGimmes: [String]? = nil, followers: [String]? = nil,
         following: [String]? = nil, money: Float? = 0.0) {
        self.username = username ?? ""
        self.email = email ?? ""
        self.paypal = paypal ?? ""
        self.giveaways = giveaways ?? []
        self.gimmes = gimmes ?? []
        self.joinedGimmes = joinedGimmes ?? []
        self.followers = followers ?? []
        self.following = following ?? []
        self.money = money ?? 0.0
    }
}

struct GiveawayData {
    var userID: String
    var username: String
    var postedTime: Date
    var expirationTime: Date
    var caption: String
    var maxNumWinners: Int
    var donationAmount: Float
    var joinedUsers: [String]
    var likedUsers: [String]
    var comments: [Comment]
    var winners: [String]
    
    init(userID: String? = nil, username: String? = nil,
         postedTime: Date? = nil, expirationTime: Date? = nil, caption: String? = nil, maxNumWinners: Int? = nil,
         donationAmount: Float? = nil, joinedUsers: [String]? = nil, likedUsers: [String]? = nil, comments: [Comment]? = nil, winners: [String]? = nil) {
        self.userID = userID ?? ""
        self.username = username ?? ""
        self.postedTime = postedTime ?? Date()
        self.expirationTime = expirationTime ?? Date()
        self.caption = caption ?? ""
        self.maxNumWinners = maxNumWinners ?? 0
        self.donationAmount = donationAmount ?? 0.0
        self.joinedUsers = joinedUsers ?? []
        self.likedUsers = likedUsers ?? []
        self.comments = comments ?? []
        self.winners = winners ?? []
    }
}
